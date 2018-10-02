//
//  DashboardProgramListViewModel.swift
//  genesisvision-ios
//
//  Created by George on 21/09/2018.
//  Copyright © 2018 Genesis Vision. All rights reserved.
//

import UIKit.UITableView

final class DashboardProgramListViewModel {
    
    enum SectionType {
        case programList
    }
    
    // MARK: - Variables
    var activePrograms = true
    
    var title = "Programs"
    
    var sortingDelegateManager = SortingDelegateManager()
    var programListDelegateManager: DashboardProgramListDelegateManager!
    
    var highToLowValue: Bool = false
    
    private var sections: [SectionType] = [.programList]
    
    private var router: DashboardRouter!
    private var dashboard: InvestorDashboard?
    
    weak var reloadDataProtocol: ReloadDataProtocol?
    
    var dateRangeType: DateRangeType?
    var dateRangeFrom: Date?
    var dateRangeTo: Date?
    
    var canFetchMoreResults = true
    var skip = 0
    var take = Constants.Api.take
    var totalCount = 0 {
        didSet {
            title = totalCount > 0 ? "Programs \(totalCount)" : "Programs"
        }
    }
    
    var bottomViewType: BottomViewType {
        return .sort
    }
    
    var viewModels = [DashboardTableViewCellViewModel]() {
        didSet {
            self.activeViewModels = viewModels.filter { $0.investmentProgram.isArchived != true }
            self.archiveViewModels = viewModels.filter { $0.investmentProgram.isArchived == true }
        }
    }
    var activeViewModels = [DashboardTableViewCellViewModel]()
    var archiveViewModels = [DashboardTableViewCellViewModel]()
    
    // MARK: - Init
    init(withRouter router: DashboardRouter) {
        self.router = router
        self.reloadDataProtocol = router.programListViewController
        
        programListDelegateManager = DashboardProgramListDelegateManager(with: self)
        NotificationCenter.default.addObserver(self, selector: #selector(programFavoriteStateChangeNotification(notification:)), name: .programFavoriteStateChange, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .programFavoriteStateChange, object: nil)
    }
    
    // MARK: - Public methods
    func changeFavorite(value: Bool, investmentProgramId: String, request: Bool = false, completion: @escaping CompletionBlock) {
        guard request else {
            guard let model = model(at: investmentProgramId) as? DashboardTableViewCellViewModel else { return completion(.failure(errorType: .apiError(message: nil))) }
            model.investmentProgram.isFavorite = value
            completion(.success)
            return
        }
        
        ProgramDataProvider.programFavorites(isFavorite: !value, investmentProgramId: investmentProgramId) { [weak self] (result) in
            switch result {
            case .success:
                guard let model = self?.model(at: investmentProgramId) as? DashboardTableViewCellViewModel else { return completion(.failure(errorType: .apiError(message: nil))) }
                model.investmentProgram.isFavorite = value
                completion(.success)
            case .failure(let errorType):
                print(errorType)
                completion(result)
            }
        }
    }
    
    // MARK: - Private methods
    @objc private func programFavoriteStateChangeNotification(notification: Notification) {
        if let isFavorite = notification.userInfo?["isFavorite"] as? Bool, let investmentProgramId = notification.userInfo?["investmentProgramId"] as? String {
            changeFavorite(value: isFavorite, investmentProgramId: investmentProgramId) { [weak self] (result) in
                self?.reloadDataProtocol?.didReloadData()
            }
        }
    }
}

// MARK: - TableView
extension DashboardProgramListViewModel {
    // MARK: - Public methods
    /// Return view models for registration cell Nib files
    var cellModelsForRegistration: [CellViewAnyModel.Type] {
        return [DashboardTableViewCellViewModel.self]
    }
    
    func modelsCount() -> Int {
        return activePrograms ? activeViewModels.count : archiveViewModels.count
    }
    
    func numberOfSections() -> Int {
        return modelsCount() > 0 ? sections.count : 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return modelsCount()
    }
    
    func headerTitle(for section: Int) -> String? {
        return nil
    }
}

// MARK: - Navigation
extension DashboardProgramListViewModel {
    func logoImageName() -> String? {
        let imageName = "img_dashboard_logo"
        return imageName
    }
    
    func noDataText() -> String {
        return "you don’t have \nany programs yet.."
    }
    
    func noDataImageName() -> String? {
        return logoImageName()
    }
    
    func noDataButtonTitle() -> String {
        let text = "Browse programs"
        return text.uppercased()
    }
    
    func showDetail(at indexPath: IndexPath) {
        guard let model: DashboardTableViewCellViewModel = model(at: indexPath) as? DashboardTableViewCellViewModel else { return }
        
        let investmentProgram = model.investmentProgram
        guard let investmentProgramId = investmentProgram.id else { return }
        
        router.show(routeType: .showProgramDetails(investmentProgramId: investmentProgramId.uuidString))
    }
    
    func showProgramList() {
        router.show(routeType: .programList)
    }
}

// MARK: - Fetch
extension DashboardProgramListViewModel {
    // MARK: - Public methods
    func fetch(completion: @escaping CompletionBlock) {
        fetch({ [weak self] (totalCount, viewModels) in
            self?.updateFetchedData(totalCount: totalCount, viewModels)
            }, completionError: completion)
    }
    
    func fetchMore(at row: Int) -> Bool {
        if modelsCount() - Constants.Api.fetchThreshold == row && canFetchMoreResults {
            fetchMore()
        }
        
        return skip < totalCount
    }
    
    func fetchMore() {
        guard skip < totalCount else { return }
        
        canFetchMoreResults = false
        fetch({ [weak self] (totalCount, viewModels) in
            var allViewModels = self?.viewModels ?? [DashboardTableViewCellViewModel]()
            
            viewModels.forEach({ (viewModel) in
                allViewModels.append(viewModel)
            })
            
            self?.updateFetchedData(totalCount: totalCount, allViewModels)
            }, completionError: { (result) in
                switch result {
                case .success:
                    break
                case .failure(let errorType):
                    ErrorHandler.handleError(with: errorType)
                }
        })
    }
    
    func refresh(completion: @escaping CompletionBlock) {
        skip = 0
        
        fetch({ [weak self] (totalCount, viewModels) in
            self?.updateFetchedData(totalCount: totalCount, viewModels)
            }, completionError: completion)
    }
    
    /// Get TableViewCellViewModel for IndexPath
    func model(at indexPath: IndexPath) -> CellViewAnyModel? {
        guard dashboard != nil else {
            return nil
        }
        
        return activePrograms ? activeViewModels[indexPath.row] : archiveViewModels[indexPath.row]
    }
    
    func model(at investmentProgramId: String) -> CellViewAnyModel? {
        if activePrograms {
            if let i = activeViewModels.index(where: { $0.investmentProgram.id?.uuidString == investmentProgramId }) {
                return activeViewModels[i]
            }
        } else {
            if let i = archiveViewModels.index(where: { $0.investmentProgram.id?.uuidString == investmentProgramId }) {
                return archiveViewModels[i]
            }
        }
        
        return nil
    }
    
    func getDetailsViewController(with indexPath: IndexPath) -> ProgramViewController? {
        guard let model = model(at: indexPath) as? DashboardTableViewCellViewModel else {
            return nil
        }
        
        let investmentProgram = model.investmentProgram
        guard let investmentProgramId = investmentProgram.id else { return nil}
        
        return router.getDetailsViewController(with: investmentProgramId.uuidString)
    }
    
    // MARK: - Private methods
    private func updateFetchedData(totalCount: Int, _ viewModels: [DashboardTableViewCellViewModel]) {
        self.viewModels = viewModels
        self.totalCount = totalCount
        self.skip += self.take
        self.canFetchMoreResults = true
        self.reloadDataProtocol?.didReloadData()
    }
    
    private func fetch(_ completionSuccess: @escaping (_ totalCount: Int, _ viewModels: [DashboardTableViewCellViewModel]) -> Void, completionError: @escaping CompletionBlock) {
        
        DashboardDataProvider.getProgram(with: sortingDelegateManager.sorting, completion: { [weak self] (dashboard) in
            guard let dashboard = dashboard else { return completionError(.failure(errorType: .apiError(message: nil))) }
            
            self?.dashboard = dashboard
            
            var dashboardProgramViewModels = [DashboardTableViewCellViewModel]()
            
            let totalCount = dashboard.investmentPrograms?.count ?? 0
            
            dashboard.investmentPrograms?.forEach({ (dashboardProgram) in
                let dashboardTableViewCellModel = DashboardTableViewCellViewModel(investmentProgram: dashboardProgram, reloadDataProtocol: self?.router.programListViewController, delegate:
                    self?.router.assetsViewController)
                dashboardProgramViewModels.append(dashboardTableViewCellModel)
            })
            
            completionSuccess(totalCount, dashboardProgramViewModels)
            completionError(.success)
            }, errorCompletion: completionError)
    }
}

final class DashboardProgramListDelegateManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var viewModel: DashboardProgramListViewModel?

    init(with viewModel: DashboardProgramListViewModel) {
        super.init()
        
        self.viewModel = viewModel
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let modelsCount = viewModel?.modelsCount(), modelsCount >= indexPath.row else {
            return
        }
        
        viewModel?.showDetail(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = viewModel?.model(at: indexPath) else {
            return UITableViewCell()
        }
        
        return tableView.dequeueReusableCell(withModel: model, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //        showInfiniteIndicator(value: viewModel?.fetchMore(at: indexPath.row))
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows(in: section) ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections() ?? 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        scrollView.isScrollEnabled = scrollView.contentOffset.y > -43.0
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        
        if translation.y < 0 {
            scrollView.isScrollEnabled = scrollView.contentOffset.y > -43.0
        } else {
            scrollView.isScrollEnabled = true
        }
    }
}