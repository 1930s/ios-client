//
//  ProgramInvestViewModel.swift
//  genesisvision-ios
//
//  Created by George Shaginyan on 21.02.18.
//  Copyright © 2018 Genesis Vision. All rights reserved.
//

import Foundation

final class ProgramInvestViewModel {
    // MARK: - Variables
    var title: String = "Investment"
    var investmentProgramId: String?
    
    private var rate: Double = 0.0
    private var balance: Double = 0.0 {
        didSet {
            self.exchangedBalance = balance * self.rate
        }
    }
    private var exchangedBalance: Double = 0.0
    var currency: String = "GVT"
    
    private weak var programDetailProtocol: ProgramDetailProtocol?
    
    private var router: ProgramInvestRouter!
    
    // MARK: - Init
    init(withRouter router: ProgramInvestRouter, investmentProgramId: String, currency: String, programDetailProtocol: ProgramDetailProtocol?) {
        self.router = router
        self.investmentProgramId = investmentProgramId
        self.currency = currency
        self.programDetailProtocol = programDetailProtocol
    }
    
    // MARK: - Public methods
    func getBalance(completion: @escaping (_ balance: Double, _ exchangedBalance: Double) -> Void, completionError: @escaping CompletionBlock) {
        let toCurrency = RequestRate.To(rawValue: self.currency)
        
        RateDataProvider.getTake(from: .gvt, to: toCurrency ?? RequestRate.To.gvt, completion: { (viewModel) in
            if viewModel != nil, let rate = viewModel?.rate {
                self.rate = rate
            }
            
            AuthManager.getBalance(completion: { [weak self] (value) in
                self?.balance = value
                if let balance = self?.balance, let exchangedBalance = self?.exchangedBalance {
                    completion(balance, exchangedBalance)
                }
                }, completionError: completionError)
        }, errorCompletion: completionError)
    }
    
    func getExchangedAmount(amount: Double, completion: @escaping (_ exchangedAmount: Double) -> Void, completionError: @escaping CompletionBlock) {
        guard amount > 0 else {
            return completion(0.0)
        }
        guard self.rate > 0 else {
            let toCurrency = RequestRate.To(rawValue: self.currency)
            
            RateDataProvider.getTake(from: .gvt, to: toCurrency ?? RequestRate.To.gvt, completion: { (viewModel) in
                if viewModel != nil, let rate = viewModel?.rate {
                    self.rate = rate
                }
                
                let exchangedBalance = amount * self.rate
                
                completion(exchangedBalance)
            }, errorCompletion: completionError)
            
            return
        }
        
        let exchangedBalance = amount * self.rate
        completion(exchangedBalance)
    }
    
    // MARK: - Navigation
    func invest(with value: Double, completion: @escaping CompletionBlock) {
        apiInvest(with: value, completion: completion)
    }
    
    func showInvestmentRequestedVC() {
        router.show(routeType: .investmentRequested)
    }
    
    func goToBack() {
        programDetailProtocol?.didInvested()
        router.goToBack()
    }
    
    // MARK: - Private methods
    // MARK: - API
    private func apiInvest(with value: Double, completion: @escaping CompletionBlock) {
        ProgramDataProvider.investProgram(withAmount: value, investmentProgramId: investmentProgramId, completion: { (viewModel) in
            guard let walletsViewModel = viewModel, let wallets = walletsViewModel.wallets, let wallet = wallets.first else {
                return completion(.failure(errorType: .apiError(message: nil)))
            }
            
            AuthManager.saveWalletViewModel(viewModel: wallet)
            completion(.success)
        }) { (result) in
            completion(result)
        }
    }
}
