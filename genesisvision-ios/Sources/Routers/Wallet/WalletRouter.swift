//
//  WalletRouter.swift
//  genesisvision-ios
//
//  Created by George Shaginyan on 26.01.18.
//  Copyright © 2018 Genesis Vision. All rights reserved.
//

enum WalletRouteType {
    case withdraw, deposit, programList
    case showAssetDetails(assetId: String, assetType: AssetType)
}

class WalletRouter: Router {
    
    var walletBalanceViewController: WalletBalanceViewController?
    var walletTabmanViewController: WalletViewController?
    
    // MARK: - Public methods
    func show(routeType: WalletRouteType) {
        switch routeType {
        case .withdraw:
            withdraw()
        case .deposit:
            deposit()
        case .showAssetDetails(let assetId, let assetType):
            showAssetDetails(with: assetId, assetType: assetType)
        case .programList:
            showProgramList()
        }
    }
    
    func getBalance(_ wallet: WalletData? = nil) -> WalletBalanceViewController? {
        let viewController = WalletBalanceViewController()
        let viewModel = WalletBalanceViewModel(withRouter: self, reloadDataProtocol: viewController, wallet: wallet)
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    func getWallets(_ wallet: WalletData? = nil) -> WalletListViewController? {
        guard wallet == nil else { return nil }
        
        let viewController = WalletListViewController()
        let viewModel = WalletListViewModel(withRouter: self, reloadDataProtocol: viewController)
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    func getInternalTransactions(_ wallet: WalletData? = nil) -> WalletTransactionListViewController? {
        let viewController = WalletTransactionListViewController()
        let viewModel = WalletInternalTransactionListViewModel(withRouter: self, reloadDataProtocol: viewController, wallet: wallet)
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    func getExternalTransactions(_ wallet: WalletData? = nil) -> WalletTransactionListViewController? {
        let viewController = WalletTransactionListViewController()
        let viewModel = WalletExternalTransactionListViewModel(withRouter: self, reloadDataProtocol: viewController, wallet: wallet)
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    // MARK: - Private methods
    private func showProgramList() {
        changeTab(withParentRouter: self, to: .assetList)
    }
    
    private func withdraw() {
        guard let vc = topViewController() else { return }
        
        guard let viewController = WalletWithdrawViewController.storyboardInstance(.wallet) else { return }
        let router = WalletWithdrawRouter(parentRouter: self, navigationController: navigationController)
        let viewModel = WalletWithdrawViewModel(withRouter: router, walletProtocol: vc as! WalletProtocol)
        viewController.viewModel = viewModel
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func deposit() {
        guard let viewController = WalletDepositViewController.storyboardInstance(.wallet) else { return }
        let router = WalletDepositRouter(parentRouter: self, navigationController: navigationController)
        let viewModel = WalletDepositViewModel(withRouter: router)
        viewController.viewModel = viewModel
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
}
