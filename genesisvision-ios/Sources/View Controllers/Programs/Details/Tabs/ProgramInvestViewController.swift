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
    var confirmView: InvestWithdrawConfirmView!
    
    @IBOutlet weak var numpadView: NumpadView! {
        didSet {
            numpadView.isUserInteractionEnabled = true
            numpadView.delegate = self
            numpadView.type = .currency
        }
    }
    
    // MARK: - Labels
    @IBOutlet weak var availableToInvestTitleLabel: TitleLabel! {
        didSet {
            availableToInvestTitleLabel.text = "Available to invest"
            availableToInvestTitleLabel.font = UIFont.getFont(.regular, size: 14.0)
        }
    }
    @IBOutlet weak var availableToInvestValueLabel: TitleLabel! {
        didSet {
            availableToInvestValueLabel.textColor = UIColor.primary
            availableToInvestValueLabel.font = UIFont.getFont(.regular, size: 14.0)
        }
    }
    @IBOutlet weak var amountToInvestTitleLabel: SubtitleLabel! {
        didSet {
            amountToInvestTitleLabel.text = "Amount to invest"
        }
    }
    @IBOutlet weak var amountToInvestValueLabel: TitleLabel! {
        didSet {
            amountToInvestValueLabel.font = UIFont.getFont(.regular, size: 18.0)
        }
    }
    @IBOutlet weak var amountToInvestGVTLabel: SubtitleLabel! {
        didSet {
            amountToInvestGVTLabel.font = UIFont.getFont(.regular, size: 18.0)
        }
    }
    
    @IBOutlet weak var copyMaxValueButton: UIButton! {
        didSet {
            copyMaxValueButton.setTitleColor(UIColor.Cell.title, for: .normal)
            copyMaxValueButton.titleLabel?.font = UIFont.getFont(.semibold, size: 12)
        }
    }
    
    @IBOutlet weak var entryFeeTitleLabel: SubtitleLabel! {
        didSet {
            entryFeeTitleLabel.text = "Entry fee"
            entryFeeTitleLabel.font = UIFont.getFont(.regular, size: 14.0)
        }
    }
    @IBOutlet weak var entryFeeValueLabel: TitleLabel!
    
    @IBOutlet weak var gvCommissionTitleLabel: SubtitleLabel! {
        didSet {
            gvCommissionTitleLabel.text = "GV commission"
            gvCommissionTitleLabel.font = UIFont.getFont(.regular, size: 14.0)
        }
    }
    @IBOutlet weak var gvCommissionValueLabel: TitleLabel!
    
    @IBOutlet weak var investmentAmountTitleLabel: SubtitleLabel! {
        didSet {
            investmentAmountTitleLabel.text = "Investment amount"
            investmentAmountTitleLabel.font = UIFont.getFont(.regular, size: 14.0)
        }
    }
    @IBOutlet weak var investmentAmountValueLabel: TitleLabel! {
        didSet {
            investmentAmountValueLabel.text = "0 GVT"
        }
    }

    // MARK: - Buttons
    @IBOutlet weak var investButton: ActionButton!
    
    // MARK: - Variables
    var availableToInvestValue: Double = 0.0 {
        didSet {
            self.availableToInvestValueLabel.text = availableToInvestValue.toString() + " " + Constants.gvtString
        }
    }
    
    var amountToInvestValue: Double = 0.0 {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = viewModel.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setup()
    }
    
    // MARK: - Private methods
    private func setup() {
        investButton.setEnabled(false)
        
        showProgressHUD()
        viewModel.getInfo(completion: { [weak self] (result) in
            self?.hideAll()
            
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.updateUI()
                }
            case .failure(let errorType):
                ErrorHandler.handleError(with: errorType, viewController: self)
            }
        }) { (result) in
            switch result {
            case .success:
                break
            case .failure(let errorType):
                ErrorHandler.handleError(with: errorType, viewController: self)
            }
        }
    }
    
    private func updateUI() {
        let minInvestmentAmount = viewModel.programInvestInfo?.minInvestmentAmount
        
        if let minInvestmentAmount = minInvestmentAmount {
            amountToInvestTitleLabel.text = "Amount to invest (min " + minInvestmentAmount.rounded(withType: .gvt).toString() + " \(Constants.gvtString))"
        }
        
        if let entryFee = viewModel.programInvestInfo?.entryFee, let gvCommission = viewModel.programInvestInfo?.gvCommission {
            let entryFeeGVT = entryFee * amountToInvestValue / 100
            let entryFeeGVTString = entryFeeGVT.rounded(withType: .gvt).toString()
            let entryFeeString = entryFee.rounded(toPlaces: 3).toString()
            
            let entryFeeValueLabelString = entryFeeString + "% (\(entryFeeGVTString) \(Constants.gvtString))"
            self.entryFeeValueLabel.text = entryFeeValueLabelString

            let gvCommissionGVT = gvCommission * amountToInvestValue / 100
            let gvCommissionGVTString = gvCommissionGVT.rounded(withType: .gvt).toString()
            let gvCommissionString = gvCommission.rounded(toPlaces: 3).toString()
            
            let gvCommissionValueLabelString = gvCommissionString + "% (\(gvCommissionGVTString) \(Constants.gvtString))"
            self.gvCommissionValueLabel.text = gvCommissionValueLabelString
            let investmentAmountValue = (amountToInvestValue - entryFeeGVT - gvCommissionGVT).rounded(withType: .gvt).toString()
            self.investmentAmountValueLabel.text = investmentAmountValue + " " + Constants.gvtString
        }
        
        if let availableToInvest = viewModel.programInvestInfo?.availableToInvest, let availableInWallet = viewModel.programInvestInfo?.availableInWallet {
            self.availableToInvestValue = min(availableInWallet, availableToInvest)
        }
        
        let investButtonEnabled = amountToInvestValue >= minInvestmentAmount ?? 0 && amountToInvestValue <= availableToInvestValue
        
        investButton.setEnabled(investButtonEnabled)
    }
    
    @objc private func closeButtonAction() {
        viewModel.close()
    }
    
    private func investMethod() {
        guard let minInvestmentAmount = viewModel.programInvestInfo?.minInvestmentAmount, amountToInvestValue >= minInvestmentAmount else { return showErrorHUD(subtitle: "Enter investment value, please") }
        
        showProgressHUD()
        viewModel.invest(with: amountToInvestValue) { [weak self] (result) in
            self?.hideAll()
            
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.viewModel.goToBack()
                }
            case .failure(let errorType):
                ErrorHandler.handleError(with: errorType, viewController: self, hud: true)
            }
        }
    }
    
    private func showConfirmVC() {
        bottomSheetController = BottomSheetController()
        bottomSheetController.tintColor = UIColor.Cell.bg
        bottomSheetController.containerViewBackgroundColor = UIColor.Background.gray
        bottomSheetController.initializeHeight = 520.0
        
        confirmView = InvestWithdrawConfirmView.viewFromNib()
        
        var subtitle = ""
        if let currency = viewModel.programCurrency, let periodEnds = viewModel.programInvestInfo?.periodEnds {
            subtitle = "After tapping the \"Confirm\" button, the invested GVT will be immediately converted to \(currency.rawValue). Accrual of \(currency.rawValue) to the account manager will only occur at the end of the reporting period \(periodEnds.defaultFormatString)."
        }
        
        var firstValue: String?
        if let amount = amountToInvestValueLabel.text {
             firstValue = amount + " GVT"
        }
        
        let confirmViewModel = InvestWithdrawConfirmModel(title: "Confirm Invest",
                                                          subtitle: subtitle,
                                                          programLogo: nil,
                                                          programTitle: nil,
                                                          managerName: nil,
                                                          firstTitle: amountToInvestTitleLabel.text,
                                                          firstValue: firstValue,
                                                          secondTitle: entryFeeTitleLabel.text,
                                                          secondValue: entryFeeValueLabel.text,
                                                          thirdTitle: gvCommissionTitleLabel.text,
                                                          thirdValue: gvCommissionValueLabel.text,
                                                          fourthTitle: investmentAmountTitleLabel.text,
                                                          fourthValue: investmentAmountValueLabel.text)
        confirmView.configure(model: confirmViewModel)
        bottomSheetController.addContentsView(confirmView)
        confirmView.delegate = self
        bottomSheetController.present()
    }
    
    // MARK: - Actions
    @IBAction func investButtonAction(_ sender: UIButton) {
        showConfirmVC()
    }
    
    @IBAction func copyMaxValueButtonAction(_ sender: UIButton) {
        amountToInvestValueLabel.text = availableToInvestValue.toString(withoutFormatter: true)
        amountToInvestValue = availableToInvestValue
    }
    
}

extension ProgramInvestViewController: NumpadViewProtocol {
    var maxAmount: Double? {
        return availableToInvestValue
    }
    
    var textPlaceholder: String? {
        return viewModel.labelPlaceholder
    }
    
    var numbersLimit: Int? {
        return -1
    }
    
    var currency: CurrencyType? {
        return .gvt
    }
    
    func changedActive(value: Bool) {
        numpadView.isEnable = value
    }
    
    var textLabel: UILabel {
        return self.amountToInvestValueLabel
    }
    
    func textLabelDidChange(value: Double?) {
        guard let value = value, value <= availableToInvestValue else { return }
        
        numpadView.isEnable = true
        amountToInvestValue = value
    }
}

extension ProgramInvestViewController: InvestWithdrawConfirmViewProtocol {
    func cancelButtonDidPress() {
        bottomSheetController.dismiss()
    }
    
    func confirmButtonDidPress() {
        bottomSheetController.dismiss()
        investMethod()
    }
}
