//
//  DashboardTableViewCell.swift
//  genesisvision-ios
//
//  Created by George Shaginyan on 27.02.18.
//  Copyright © 2018 Genesis Vision. All rights reserved.
//

import UIKit

class DashboardTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    var investmentProgramId: String = ""
    var investedTokens: Double = 0.0
    
    var endOfPeriod: Date?
    var isEnable: Bool = false {
        didSet {
            updatePeriodLeftValueLabel()
            contentView.backgroundColor = isEnable ? UIColor.Background.main : UIColor.Background.gray
            chartView.backgroundColor = isEnable ? UIColor.Background.main : UIColor.Background.gray
        }
    }
    
    var timer: Timer?
    
    weak var reloadDataProtocol: ReloadDataProtocol?
    
    // MARK: - Views
    @IBOutlet var programLogoImageView: ProfileImageView!
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var viewForChartView: UIView!
    @IBOutlet var chartView: ChartView! {
        didSet {
            chartView.isUserInteractionEnabled = false
            chartView.backgroundColor = UIColor.Background.main
        }
    }
    
    // MARK: - Labels
    @IBOutlet var noDataLabel: UILabel! {
        didSet {
            noDataLabel.textColor = UIColor.Font.dark
        }
    }
    
    @IBOutlet var programTitleLabel: UILabel! 
    @IBOutlet var managerNameLabel: UILabel!
    
    @IBOutlet var tokensCountValueLabel: UILabel!
    @IBOutlet var tokensCountTitleLabel: UILabel!
    
    @IBOutlet var profitValueLabel: UILabel!
    @IBOutlet var profitTitleLabel: UILabel!
    
    @IBOutlet var periodLeftValueLabel: UILabel!
    @IBOutlet var periodLeftTitleLabel: UILabel!
    
    @IBOutlet var currencyLabel: CurrencyLabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = UIColor.Background.main
    }
    
    deinit {
        stopTimer()
    }
    
    // MARK: - Public methods
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: - Private methods
    private func updatePeriodLeftValueLabel() {
        periodLeftTitleLabel.isHidden = !isEnable
        
        timer?.invalidate()
        
        if isEnable {
            periodLeftValueLabel.numberOfLines = 1
            periodLeftValueLabel.font = UIFont.getFont(.regular, size: 30)
            
//            updatePeriodLeftValue()
            
            if let endOfPeriod = endOfPeriod {
                let periodLeft = getPeriodLeft(endOfPeriod: endOfPeriod)
                let periodLeftValue = periodLeft.0
                
                if periodLeftValue >= 0 {
//                    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updatePeriodLeftValue), userInfo: nil, repeats: true)
                }
            }
        } else {
            programClosed()
        }
    }
    
    private func programClosed() {
        periodLeftValueLabel.numberOfLines = 2
        periodLeftValueLabel.font = UIFont.getFont(.bold, size: 15)
        
        periodLeftValueLabel.text = "Program \nclosed"
        periodLeftTitleLabel.isHidden = true
    }
    
    @objc func updatePeriodLeftValue() {
        if let endOfPeriod = endOfPeriod {
            let periodLeft = getPeriodLeft(endOfPeriod: endOfPeriod)
            let periodLeftValue = periodLeft.0
            
            DispatchQueue.main.async {
                if periodLeftValue >= 0, let periodLeftTimeValue = periodLeft.1 {
                    self.periodLeftValueLabel.isHidden = false
                    self.periodLeftTitleLabel.isHidden = false
                    self.periodLeftValueLabel.text = periodLeftValue.toString()
                    self.periodLeftTitleLabel.text = periodLeftTimeValue.uppercased() + " LEFT"
                } else {
                    self.periodLeftValueLabel.isHidden = true
                    self.periodLeftTitleLabel.isHidden = true
                    self.reloadDataProtocol?.didReloadData()
                }
            }
        }
    }
}
