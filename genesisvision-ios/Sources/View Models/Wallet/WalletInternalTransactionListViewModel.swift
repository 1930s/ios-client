//
//  WalletInternalTransactionListViewModel.swift
//  genesisvision-ios
//
//  Created by George on 08/02/2019.
//  Copyright © 2019 Genesis Vision. All rights reserved.
//

import UIKit.UITableViewHeaderFooterView

final class WalletInternalTransactionListViewModel: WalletTransactionListViewModel {
    enum SectionType {
        case header
        case transactions
    }
    
    // MARK: - Variables
    var title: String = "Transactions"
    
    var wallet: WalletData?
    
    private var sections: [SectionType] = [.transactions]
    
    private var router: WalletRouter!
    private var transactions = [WalletTransactionTableViewCellViewModel]()
    private weak var reloadDataProtocol: ReloadDataProtocol?
    
    var canFetchMoreResults = true
    var dataType: DataType = .api
    var skip = 0            //offset
    var take = ApiKeys.take
    var totalCount = 0      //total count of programs
    
    // MARK: - Init
    init(withRouter router: WalletRouter, reloadDataProtocol: ReloadDataProtocol?, wallet: WalletData? = nil) {
        self.router = router
        self.reloadDataProtocol = reloadDataProtocol
        self.wallet = wallet
    }
}

// MARK: - TableView
extension WalletInternalTransactionListViewModel {
    /// Return view models for registration cell Nib files
    var cellModelsForRegistration: [CellViewAnyModel.Type] {
        return [WalletTransactionTableViewCellViewModel.self]
    }
    
    /// Return view models for registration header/footer Nib files
    var viewModelsForRegistration: [UITableViewHeaderFooterView.Type] {
        return []
    }
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        switch sections[section] {
        case .header:
            return 0
        case .transactions:
            return transactions.count
        }
    }
    
    func headerTitle(for section: Int) -> String? {
        switch sections[section] {
        case .transactions:
            return "Transaction history"
        case .header:
            return nil
        }
    }
    
    func headerHeight(for section: Int) -> CGFloat {
        switch sections[section] {
        case .header:
            return 0.0
        case .transactions:
            return 78.0
        }
    }
    
    /// Get TableViewCellViewModel for IndexPath
    func model(at indexPath: IndexPath) -> CellViewAnyModel? {
        let type = sections[indexPath.section]
        switch type {
        case .header:
            return nil
        case .transactions:
            return transactions[indexPath.row]
        }
    }
}

// MARK: - Fetch
extension WalletInternalTransactionListViewModel {
    /// Fetch transactions from API -> Save fetched data -> Return CompletionBlock
    func fetch(completion: @escaping CompletionBlock) {
        fetchTransactions({ [weak self] (totalCount, viewModels) in
            self?.updateFetchedData(totalCount: totalCount, viewModels)
            completion(.success)
            }, completionError: completion)
        
    }
    
    /// Fetch more transactions from API -> Save fetched data -> Return CompletionBlock
    func fetchMore(at indexPath: IndexPath) -> Bool {
        if numberOfRows(in: indexPath.section) - ApiKeys.fetchThreshold == indexPath.row && canFetchMoreResults && transactions.count >= take {
            fetchMoreTransactions()
        }
        
        return skip < totalCount
    }
    
    func fetchMoreTransactions() {
        guard skip < totalCount else { return }
        
        canFetchMoreResults = false
        fetchTransactions({ [weak self] (totalCount, viewModels) in
            var allViewModels = self?.transactions ?? [WalletTransactionTableViewCellViewModel]()
            
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
    
    /// Fetch transactions from API -> Save fetched data -> Return CompletionBlock
    func refresh(completion: @escaping CompletionBlock) {
        skip = 0
        
        fetchTransactions({ [weak self] (totalCount, viewModels) in
            self?.updateFetchedData(totalCount: totalCount, viewModels)
            }, completionError: completion)
    }
    
    /// Update saved transactions (WalletTransactionTableViewCellViewModel)
    private func updateFetchedData(totalCount: Int, _ viewModels: [WalletTransactionTableViewCellViewModel]) {
        self.transactions = viewModels
        self.totalCount = totalCount
        self.skip += self.take
        self.canFetchMoreResults = true
        self.reloadDataProtocol?.didReloadData()
    }
    
    /// Save [WalletTransaction] and total -> Return [WalletTransactionTableViewCellViewModel] or error
    private func fetchTransactions(_ completionSuccess: @escaping (_ totalCount: Int, _ viewModels: [WalletTransactionTableViewCellViewModel]) -> Void, completionError: @escaping CompletionBlock) {
        
        let currency = WalletAPI.Currency_v10WalletMultiTransactionsGet(rawValue: wallet?.currency?.rawValue ?? "")
        
        WalletDataProvider.getMultiTransactions(currency: currency, skip: skip, take: take, completion: { (transactionsViewModel) in
            guard transactionsViewModel != nil else {
                return ErrorHandler.handleApiError(error: nil, completion: completionError)
            }
            var viewModels = [WalletTransactionTableViewCellViewModel]()
            
            let totalCount = transactionsViewModel?.total ?? 0
            
            transactionsViewModel?.transactions?.forEach({ (walletTransaction) in
                let viewModel = WalletTransactionTableViewCellViewModel(walletTransaction: walletTransaction)
                viewModels.append(viewModel)
            })
            
            completionSuccess(totalCount, viewModels)
            completionError(.success)
        }, errorCompletion: completionError)
    }
}


// MARK: - Navigation
extension WalletInternalTransactionListViewModel {
    func showDetail(at indexPath: IndexPath) {
        //        guard let model: WalletTransactionTableViewCellViewModel = model(at: indexPath) as? WalletTransactionTableViewCellViewModel,
        //            let program = model.walletTransaction.program,
        //            let programId = program.id
        //            else { return }
        //
        //        router.show(routeType: .showProgramDetails(programId: programId.uuidString))
    }
}

extension WalletInternalTransactionListViewModel {
    func logoImageName() -> String {
        let imageName = "img_wallet_logo"
        return imageName
    }
    
    func noDataText() -> String {
        return "You don’t have any transactions yet"
    }
    
    func noDataImageName() -> String? {
        return nil
    }
    
    func noDataButtonTitle() -> String {
        let text = ""
        return text
    }
}

