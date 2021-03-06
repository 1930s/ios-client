//
//  FundInvestNowTableViewCellViewModel.swift
//  genesisvision-ios
//
//  Created by George on 25/10/2018.
//  Copyright © 2018 Genesis Vision. All rights reserved.
//

import Foundation

struct FundInvestNowTableViewCellViewModel {
    let fundDetailsFull: FundDetailsFull?
    weak var investNowProtocol: InvestNowProtocol?
}

extension FundInvestNowTableViewCellViewModel: CellViewModel {
    func setup(on cell: InvestNowTableViewCell) {
        cell.investButton.setEnabled(false)
        
        if let canInvest = fundDetailsFull?.personalFundDetails?.canInvest {
            cell.investButton.setEnabled(canInvest)
        }
        
        cell.disclaimerLabel.isHidden = true
        
        cell.investNowProtocol = investNowProtocol
        
        cell.titleLabel.text = "Invest Now"
        cell.investButton.setTitle("Invest", for: .normal)
        
         if let entryFee = fundDetailsFull?.entryFee {
            cell.entryFeeTitleLabel.text = "entry fee"
            cell.entryFeeValueLabel.text = entryFee.rounded(withType: .undefined).toString() + "%"
        }
        
        if let exitFee = fundDetailsFull?.exitFee {
            cell.successFeeTitleLabel.text = "exit fee"
            cell.successFeeValueLabel.text = exitFee.rounded(withType: .undefined).toString() + "%"
        }
        
        cell.investStackView.isHidden = true
    }
}
