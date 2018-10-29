//
//  ProgramListViewModel.swift
//  genesisvision-ios
//
//  Created by George Shaginyan on 25.01.18.
//  Copyright © 2018 Genesis Vision. All rights reserved.
//

import Foundation

enum ProgramListViewState {
    case programList, programListWithSignIn
}

final class ProgramListViewModel: ListViewModelProtocol {
    var type: ListType = .programList
    
    // MARK: - Variables
    var title: String = "Programs"
    var roundNumber: Int = 1
    
    var sortingDelegateManager: SortingDelegateManager!
    
    internal var sections: [SectionType] = [.assetList]
    
    var router: ListRouterProtocol!
    var state: ProgramListViewState?
    private weak var reloadDataProtocol: ReloadDataProtocol?
    var canFetchMoreResults = true
    var dataType: DataType = .api
    var count: String = ""
    var chartPointsCount = Constants.Api.equityChartLength
    
    var levelMin = 1
    var levelMax = 7
    
    var mask: String?
    var isFavorite: Bool = false
    
    var skip = 0
    var take = Constants.Api.take
    var totalCount = 0 {
        didSet {
            count = "\(totalCount) programs"
        }
    }

    private var programsList: ProgramsList?
    
    var dateFrom: Date?
    var dateTo: Date?
    var bottomViewType: BottomViewType {
        return signInButtonEnable ? .signInWithDateRange : .dateRange
    }
    
    var searchText = "" {
        didSet {
            mask = searchText
        }
    }
    var viewModels = [CellViewAnyModel]()
    
    // MARK: - Init
    init(withRouter router: ProgramListRouter, reloadDataProtocol: ReloadDataProtocol?) {
        self.router = router
        self.reloadDataProtocol = reloadDataProtocol
        
        state = isLogin() ? .programList : .programListWithSignIn
        sortingDelegateManager = SortingDelegateManager(.programs)
        
        NotificationCenter.default.addObserver(self, selector: #selector(programFavoriteStateChangeNotification(notification:)), name: .programFavoriteStateChange, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .programFavoriteStateChange, object: nil)
    }
    
    // MARK: - Public methods
    func noDataText() -> String {
        return "You do not have any programs yet"
    }
    
    func isLogin() -> Bool {
        return AuthManager.isLogin()
    }
    
    var signInButtonEnable: Bool {
        return state == .programListWithSignIn
    }
    
    func changeFavorite(value: Bool, assetId: String, request: Bool = false, completion: @escaping CompletionBlock) {
        guard request else {
            guard let model = model(at: assetId) as? ProgramTableViewCellViewModel else { return completion(.failure(errorType: .apiError(message: nil))) }
            model.program.personalDetails?.isFavorite = value
            completion(.success)
            return
        }
        
        
        ProgramsDataProvider.favorites(isFavorite: !value, assetId: assetId) { [weak self] (result) in
            switch result {
            case .success:
                guard let model = self?.model(at: assetId) as? ProgramTableViewCellViewModel else { return completion(.failure(errorType: .apiError(message: nil))) }
                model.program.personalDetails?.isFavorite = value
                completion(.success)
            case .failure(let errorType):
                print(errorType)
                completion(result)
            }
        }
    }
    
    // MARK: - Private methods
    @objc private func programFavoriteStateChangeNotification(notification: Notification) {
        if let isFavorite = notification.userInfo?["isFavorite"] as? Bool, let assetId = notification.userInfo?["programId"] as? String {
            changeFavorite(value: isFavorite, assetId: assetId) { [weak self] (result) in
                self?.reloadDataProtocol?.didReloadData()
            }
        }
    }
}

// MARK: - Fetch
extension ProgramListViewModel {
    // MARK: - Public methods
    func fetch(completion: @escaping CompletionBlock) {
        fetch({ [weak self] (totalCount, viewModels) in
            self?.updateFetchedData(totalProgramCount: totalCount, viewModels)
            }, completionError: completion)
    }
    
    func fetchMore() {
        guard skip < totalCount else { return }

        canFetchMoreResults = false
        fetch({ [weak self] (totalCount, viewModels) in
            var allViewModels = self?.viewModels ?? [ProgramTableViewCellViewModel]()

            viewModels.forEach({ (viewModel) in
                allViewModels.append(viewModel)
            })

            self?.updateFetchedData(totalProgramCount: totalCount, allViewModels as! [ProgramTableViewCellViewModel])
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
            self?.updateFetchedData(totalProgramCount: totalCount, viewModels)
            }, completionError: completion)
    }
    
    private func updateFetchedData(totalProgramCount: Int, _ viewModels: [ProgramTableViewCellViewModel]) {
        self.viewModels = viewModels
        self.totalCount = totalProgramCount
        self.skip += self.take
        self.canFetchMoreResults = true
        self.reloadDataProtocol?.didReloadData()
    }

    // MARK: - Private methods
    private func fetch(_ completionSuccess: @escaping (_ totalCount: Int, _ viewModels: [ProgramTableViewCellViewModel]) -> Void, completionError: @escaping CompletionBlock) {
        switch dataType {
        case .api:
            let sorting = sortingDelegateManager.sortingManager?.getSelectedSorting()
            let currencySecondary = ProgramsAPI.CurrencySecondary_v10ProgramsGet(rawValue: getSelectedCurrency()) ?? .btc
            
            ProgramsDataProvider.get(levelMin: levelMin, levelMax: levelMax, profitAvgMin: nil, profitAvgMax: nil, sorting: sorting as? ProgramsAPI.Sorting_v10ProgramsGet , programCurrency: nil, currencySecondary: currencySecondary, statisticDateFrom: dateFrom, statisticDateTo: dateTo, chartPointsCount: chartPointsCount, mask: mask, facetId: nil, isFavorite: isFavorite, ids: nil, skip: skip, take: take, completion: { [weak self] (programsList) in
                guard let programsList = programsList else { return completionError(.failure(errorType: .apiError(message: nil))) }
                
                self?.programsList = programsList
                
                var viewModels = [ProgramTableViewCellViewModel]()
                
                let totalCount = programsList.total ?? 0
                
                programsList.programs?.forEach({ (program) in
                    guard let programListRouter: ProgramListRouter = self?.router as? ProgramListRouter else { return completionError(.failure(errorType: .apiError(message: nil))) }
                    
                    let programTableViewCellViewModel = ProgramTableViewCellViewModel(program: program, delegate: programListRouter.programsViewController)
                    viewModels.append(programTableViewCellViewModel)
                })
                
                completionSuccess(totalCount, viewModels)
                completionError(.success)
            }, errorCompletion: completionError)
        case .fake:
            break
        }
    }
}