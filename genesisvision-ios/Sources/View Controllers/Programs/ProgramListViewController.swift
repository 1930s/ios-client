//
//  ProgramListViewController.swift
//  genesisvision-ios
//
//  Created by George Shaginyan on 16.01.18.
//  Copyright © 2018 Genesis Vision. All rights reserved.
//

import UIKit

class ProgramListViewController: BaseViewControllerWithTableView {
    
    // MARK: - Variables
    private var signInButtonEnable: Bool = false
    
    // MARK: - View Model
    var viewModel: ListViewModelProtocol!
    
    // MARK: - Outlets
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        searchBar.delegate = self
        searchBar.showsCancelButton = false
        searchBar.isTranslucent = false
        searchBar.backgroundColor = UIColor.BaseView.bg
        searchBar.barTintColor = UIColor.primary
        searchBar.tintColor = UIColor.primary
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
    @IBOutlet override var tableView: UITableView! {
        didSet {
            setupSignInButton()
            setupTableConfiguration()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Private methods
    private func setupSignInButton() {
        if let viewModel = viewModel as? ProgramListViewModel {
            signInButtonEnable = viewModel.signInButtonEnable
        }
        
        signInButton.isHidden = !signInButtonEnable
    }
    
    private func setup() {
        registerForPreviewing()
        
        setupUI()
    }
    
    private func setupUI() {
        noDataTitle = viewModel.noDataText()
        noDataButtonTitle = viewModel.noDataButtonTitle()
        if let imageName = viewModel.noDataImageName() {
            noDataImage = UIImage(named: imageName)
        }
        
        bottomViewType = viewModel.bottomViewType
        
        let sortTitle = self.viewModel?.sortingDelegateManager.sortingManager?.sortTitle()
        sortButton.setTitle(sortTitle, for: .normal)
        
        if signInButtonEnable {
            showNewVersionAlertIfNeeded(self)
        }

        setupSearchBar()
    }
    
    private func setupSearchBar() {
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        if #available(iOS 11.0, *) {
            searchBar.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        }
    }
    
    private func setupTableConfiguration() {
        tableView.configure(with: .defaultConfiguration)
        tableView.contentInset.bottom = signInButtonEnable ? 82.0 : 0.0
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNibs(for: viewModel.cellModelsForRegistration)
        
        setupPullToRefresh(scrollView: tableView)
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
            self.refreshControl?.endRefreshing()

            UIView.setAnimationsEnabled(false)
            self.tableView?.reloadData()
            UIView.setAnimationsEnabled(true)
        }
    }
    
    private func sortMethod() {
        guard let sortingManager = viewModel.sortingDelegateManager.sortingManager else { return }
        
        bottomSheetController = BottomSheetController()
        bottomSheetController.addNavigationBar("Sort by", buttonTitle: "High to Low", buttonSelectedTitle: "Low to High", buttonAction: #selector(highToLowButtonAction), buttonTarget: self, buttonSelected: !sortingManager.highToLowValue)
        
        bottomSheetController.addTableView { [weak self] tableView in
            if let sortingDelegateManager = self?.viewModel.sortingDelegateManager {
                tableView.registerNibs(for: sortingDelegateManager.cellModelsForRegistration)
                tableView.delegate = sortingDelegateManager
                tableView.dataSource = sortingDelegateManager
            }
            
            tableView.separatorStyle = .none
        }
        
        viewModel.sortingDelegateManager.delegate = self
        bottomSheetController.present()
    }
    
    override func fetch() {
        viewModel.refresh { [weak self] (result) in
            self?.hideAll()
            
            switch result {
            case .success:
                break
            case .failure(let errorType):
                ErrorHandler.handleError(with: errorType, viewController: self)
            }
        }
    }
    
    override func pullToRefresh() {
        super.pullToRefresh()
        
        fetch()
    }
    
    override func updateData(from dateFrom: Date?, to dateTo: Date?) {
        viewModel.filterModel.dateRangeModel.dateFrom = dateFrom
        viewModel.filterModel.dateRangeModel.dateTo = dateTo
        
        showProgressHUD()
        fetch()
    }
    
    // MARK: - Actions
    @objc func highToLowButtonAction() {
        if let sortingManager = viewModel.sortingDelegateManager.sortingManager {
            sortingManager.highToLowValue = !sortingManager.highToLowValue
        }
        
        bottomSheetController.dismiss()
        
        showProgressHUD()
        fetch()
    }
}

extension ProgramListViewController {
    override func sortButtonAction() {
        sortMethod()
    }
    
    override func filterButtonAction() {
        if let viewModel = viewModel as? ProgramListViewModel {
            viewModel.showFilterVC(filterType: .programs, sortingType: .programs)
        }
    }
    
    override func signInButtonAction() {
        if let viewModel = viewModel as? ProgramListViewModel {
            viewModel.showSignInVC()
        }
    }
}

extension ProgramListViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard viewModel.modelsCount() >= indexPath.row else {
            return
        }
        
        viewModel.showDetail(at: indexPath)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = viewModel.model(at: indexPath) else {
            return TableViewCell()
        }

        return tableView.dequeueReusableCell(withModel: model, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        showInfiniteIndicator(value: viewModel.fetchMore(at: indexPath.row))
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
}


// MARK: - UIViewControllerPreviewingDelegate
extension ProgramListViewController: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing,
                           viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        let cellPosition = tableView.convert(location, from: view)
        
        guard let indexPath = tableView.indexPathForRow(at: cellPosition),
            let vc = viewModel.getDetailsViewController(with: indexPath),
            let cell = tableView.cellForRow(at: indexPath)
            else { return nil }
        
        vc.preferredContentSize = CGSize(width: 0.0, height: 500)
        previewingContext.sourceRect = view.convert(cell.frame, from: tableView)
        
        return vc
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        push(viewController: viewControllerToCommit)
    }
}

// MARK: - ReloadDataProtocol
extension ProgramListViewController: ReloadDataProtocol {
    func didReloadData() {
        reloadData()
    }
}

// MARK: - FavoriteStateChangeProtocol
extension ProgramListViewController: FavoriteStateChangeProtocol {
    var filterDateRangeModel: FilterDateRangeModel? {
        return dateRangeModel
    }
    
    func didChangeFavoriteState(with programID: String, value: Bool, request: Bool) {
        showProgressHUD()
        viewModel.changeFavorite(value: value, assetId: programID, request: request) { [weak self] (result) in
            self?.hideAll()
        }
    }
}

extension ProgramListViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        var value = false
        guard let searchText = searchBar.text else { return }
        
        if !searchText.isEmpty, searchText != viewModel.filterModel.mask {
            value = true
        }
        
        if searchText.isEmpty, let mask = viewModel.filterModel.mask, !mask.isEmpty {
            value = true
        }
        
        if value {
            return
        }
        
        viewModel.filterModel.mask = searchText
        
        updateData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        searchBar.text = ""
        
        guard let searchText = searchBar.text, let mask = viewModel.filterModel.mask, !mask.isEmpty else {
            return
        }
        
        viewModel.filterModel.mask = searchText
        
        updateData()
    }
}

extension ProgramListViewController: SortingDelegate {
    func didSelectSorting() {
        bottomSheetController.dismiss()
        
        showProgressHUD()
        fetch()
    }
}
