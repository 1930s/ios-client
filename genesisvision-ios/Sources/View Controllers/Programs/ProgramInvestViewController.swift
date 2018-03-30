//
//  ProgramInvestViewController.swift
//  genesisvision-ios
//
//  Created by George Shaginyan on 21.02.18.
//  Copyright © 2018 Genesis Vision. All rights reserved.
//

import UIKit

class ProgramInvestViewController: BaseViewController {
    
    var viewModel: ProgramInvestViewModel!
    
    // MARK: - Views
    @IBOutlet var numpadView: NumpadView! {
        didSet {
            numpadView.delegate = self
        }
    }
    
    // MARK: - Labels
    @IBOutlet var balanceLabel: UILabel! {
        didSet {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(copyAllButtonAction))
            tapGesture.numberOfTapsRequired = 1
            balanceLabel.isUserInteractionEnabled = true
            balanceLabel.addGestureRecognizer(tapGesture)
        }
    }
    
    @IBOutlet var balanceCurrencyLabel: UILabel!
    @IBOutlet var exchangedBalanceLabel: UILabel!
    @IBOutlet var exchangedBalanceCurrencyLabel: UILabel!
    
    @IBOutlet var amountLabel: AmountLabel! {
        didSet {
            amountLabel.font = UIFont.getFont(.light, size: 72)
        }
    }
    @IBOutlet var amountCurrencyLabel: UILabel!
    @IBOutlet var exchangedAmountLabel: UILabel!
    @IBOutlet var exchangedAmountCurrencyLabel: UILabel!
    
    // MARK: - Buttons
    @IBOutlet var investButton: UIButton!
    
    // MARK: - Variables
    var balance: Double = 0.0 {
        didSet {
            self.balanceLabel.text = balance.toString()
        }
    }
    var exchangedBalance: Double = 0.0 {
        didSet {
            self.exchangedBalanceLabel.text = exchangedBalance.toString()
        }
    }
    
    var enteredAmount: Double = 0.0 {
        didSet {
            viewModel.getExchangedAmount(amount: enteredAmount, completion: { [weak self] (exchangedAmountValue) in
                self?.exchangedAmountLabel.text = exchangedAmountValue.toString()
            }) { (result) in
                switch result {
                case .success:
                    break
                case .failure(let errorType):
                    ErrorHandler.handleError(with: errorType)
                }
            }
            
            investButton(enable: enteredAmount > 0 && enteredAmount <= balance)
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        setupNavigationBar()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        setupNavigationBar(with: .primary)
        
        investButton(enable: false)

        viewModel.getBalance(completion: { [weak self] (balance, exchangedBalance) in
            self?.balance = balance
            self?.exchangedBalance = exchangedBalance
        }) { (result) in
            switch result {
            case .success:
                break
            case .failure(let errorType):
                ErrorHandler.handleError(with: errorType)
            }
        }
        
        self.balanceCurrencyLabel.text = "GVT"
        self.exchangedBalanceCurrencyLabel.text = viewModel.currency
        self.amountCurrencyLabel.text = "GVT"
        self.exchangedAmountCurrencyLabel.text = viewModel.currency
    }
    
    private func investButton(enable: Bool) {
        investButton.isUserInteractionEnabled = enable
        investButton.backgroundColor = enable ? UIColor.Button.primary : UIColor.Button.primary.withAlphaComponent(0.3)
    }
    
    private func investMethod() {
        hideKeyboard()
        
        guard let text = amountLabel.text,
            let amount = text.doubleValue
            else { return showErrorHUD(subtitle: "Enter investment value, please") }
        
        showProgressHUD()
        viewModel.invest(with: amount) { [weak self] (result) in
            self?.hideAll()
            
            switch result {
            case .success:
                self?.showSuccessHUD(completion: { (success) in
                    self?.viewModel.goToBack()
                })
            case .failure(let errorType):
                ErrorHandler.handleError(with: errorType, viewController: self, hud: true)
            }
        }
    }
    
    @objc private func copyAllButtonAction() {        
        enteredAmount = balance
        amountLabel.text = balance.toString(withoutFormatter: true)
    }
    
    // MARK: - Actions
    @IBAction func investButtonAction(_ sender: UIButton) {
        investMethod()
    }
}

extension ProgramInvestViewController: NumpadViewProtocol {
    var textLabel: UILabel {
        return self.amountLabel
    }
    
    func textLabelDidChange(value: Double?) {
        enteredAmount = value != nil ? value! : 0.0
    }
}
