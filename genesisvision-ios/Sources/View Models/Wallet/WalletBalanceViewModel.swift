//
//  WalletBalanceViewModel.swift
//  genesisvision-ios
//
//  Created by George on 11/02/2019.
//  Copyright © 2019 Genesis Vision. All rights reserved.
//

import Foundation

class WalletBalanceViewModel {
    enum SectionType {
        case balance
    }
    
    // MARK: - Variables
    var title = "Balance"
    
    private var sections: [SectionType] = [.balance]
    
    var router: WalletRouter!
    
    var wallet: WalletData?
    
    weak var reloadDataProtocol: ReloadDataProtocol?
    
    var viewModels = [WalletBalanceTableViewCellViewModel]()
    
    init(withRouter router: WalletRouter, reloadDataProtocol: ReloadDataProtocol?, wallet: WalletData? = nil) {
        self.router = router
        self.reloadDataProtocol = reloadDataProtocol
        self.wallet = wallet
    }
    
    func fetch() {
        guard let currency = WalletAPI.Currency_v10WalletMultiByCurrencyGet(rawValue: getSelectedCurrency()) else { return }
        
        guard let wallet = wallet else {
            WalletDataProvider.getMulti(with: currency, completion: { [weak self] (wallet) in
                guard let grandTotal = wallet?.grandTotal else { return }
                self?.viewModels = [WalletBalanceTableViewCellViewModel.init(type: .total, grandTotal: grandTotal, selectedWallet: nil),
                                               WalletBalanceTableViewCellViewModel.init(type: .available, grandTotal: grandTotal, selectedWallet: nil),
                                               WalletBalanceTableViewCellViewModel.init(type: .invested, grandTotal: grandTotal, selectedWallet: nil),
                                               WalletBalanceTableViewCellViewModel.init(type: .pending, grandTotal: grandTotal, selectedWallet: nil)]
                
                self?.reloadDataProtocol?.didReloadData()
            }) { (result) in
                print("ERROR")
            }
            
            return
        }
        
        self.viewModels = [WalletBalanceTableViewCellViewModel.init(type: .total, grandTotal: nil, selectedWallet: wallet),
                            WalletBalanceTableViewCellViewModel.init(type: .available, grandTotal: nil, selectedWallet: wallet),
                            WalletBalanceTableViewCellViewModel.init(type: .invested, grandTotal: nil, selectedWallet: wallet),
                            WalletBalanceTableViewCellViewModel.init(type: .pending, grandTotal: nil, selectedWallet: wallet)]
        
        self.reloadDataProtocol?.didReloadData()
    }
}

extension WalletBalanceViewModel {
    // MARK: - Public methods
    /// Return view models for registration cell Nib files
    var cellModelsForRegistration: [CellViewAnyModel.Type] {
        return [WalletBalanceTableViewCellViewModel.self]
    }
    
    func modelsCount() -> Int {
        return viewModels.count
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
    
    func model(at indexPath: IndexPath) -> WalletBalanceTableViewCellViewModel? {
        return viewModels[indexPath.row]
    }
}

// MARK: - Navigation
extension WalletBalanceViewModel {
    func withdraw() {
        router.show(routeType: .withdraw)
    }
    
    func deposit() {
        router.show(routeType: .deposit)
    }
}

extension WalletBalanceViewModel {
    func logoImageName() -> String {
        let imageName = "img_wallet_logo"
        return imageName
    }
    
    func noDataText() -> String {
        return "You don’t have any wallets yet"
    }
    
    func noDataImageName() -> String? {
        return nil
    }
    
    func noDataButtonTitle() -> String {
        let text = ""
        return text
    }
}

