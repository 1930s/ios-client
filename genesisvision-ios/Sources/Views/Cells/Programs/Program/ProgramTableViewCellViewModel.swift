//
//  ProgramTableViewCellViewModel.swift
//  genesisvision-ios
//
//  Created by George Shaginyan on 16.01.18.
//  Copyright © 2018 Genesis Vision. All rights reserved.
//

import Foundation
import Kingfisher

struct ProgramTableViewCellViewModel {
    let program: ProgramDetails
    weak var delegate: ProgramProtocol?
}

extension ProgramTableViewCellViewModel: CellViewModel {
    func setup(on cell: ProgramTableViewCell) {
        
        cell.bottomStackView.isHidden = true
        cell.chartView.isHidden = true
        cell.noDataLabel.isHidden = false
        cell.viewForChartView.isHidden = cell.chartView.isHidden
        cell.delegate = delegate
        
        cell.noDataLabel.text = String.Alerts.ErrorMessages.noDataText
        
        if let chart = program.chart {
            cell.chartView.isHidden = false
            cell.viewForChartView.isHidden = cell.chartView.isHidden
            cell.noDataLabel.isHidden = true
            cell.chartView.setup(chartType: .default, lineChartData: chart)
        }
        
        cell.stackView.spacing = cell.chartView.isHidden ? 24 : 8
        
        if let title = program.title {
            cell.programTitleLabel.text = title
        }
        
        if let managerName = program.manager?.username {
            cell.managerNameLabel.text = "by " + managerName
        }
        
        if let programId = program.id?.uuidString {
            cell.programId = programId
        }
        
        if let level = program.level {
            cell.programLogoImageView.levelButton.setTitle(level.toString(), for: .normal)
        }
        
        if let currency = program.currency {
            cell.currencyLabel.text = currency.rawValue
        }
        
        cell.firstTitleLabel.text = "period"
        if let periodStarts = program.periodStarts, let periodEnds = program.periodEnds, let periodDuration = program.periodDuration {
            cell.firstValueLabel.text = periodEnds.timeSinceDate(fromDate: periodStarts)
            
            let today = Date()
            let periodLeft = periodEnds.timeSinceDate(fromDate: today)
            
            cell.firstValueLabel.text = periodLeft.isEmpty ? "0" : periodLeft

            if let minutes = periodEnds.getDateComponents(ofComponent: Calendar.Component.minute, fromDate: today).minute {
                cell.periodLeftProgressView.setProgress(to: Double(periodDuration - minutes) / Double(periodDuration), withAnimation: false)
            }
        } else {
            cell.firstValueLabel.text = ""
        }
        
        
        cell.secondTitleLabel.text = "balance"
        if let balance = program.statistic?.balanceGVT?.amount {
            cell.secondValueLabel.text = balance.rounded(withType: .gvt).toString() + " \(Constants.gvtString)"
        } else {
            cell.secondValueLabel.text = ""
        }
        
        cell.thirdTitleLabel.text = "av. to invest"
        if let availableInvestment = program.availableInvestment {
            cell.thirdValueLabel.text = availableInvestment.rounded(withType: .gvt).toString() + " \(Constants.gvtString)"
        } else {
            cell.thirdValueLabel.text = ""
        }
        
        
        cell.favoriteButton.isHidden = !AuthManager.isLogin()
        
        if let isFavorite = program.personalDetails?.isFavorite {
            cell.favoriteButton.isSelected = isFavorite
        }
        
        cell.programLogoImageView.profilePhotoImageView.image = UIImage.programPlaceholder
        
        if let logo = program.logo, let fileUrl = getFileURL(fileName: logo) {
            cell.programLogoImageView.profilePhotoImageView.kf.indicatorType = .activity
            cell.programLogoImageView.profilePhotoImageView.kf.setImage(with: fileUrl, placeholder: UIImage.programPlaceholder)
        }
        
        if let color = program.color {
            cell.programLogoImageView.profilePhotoImageView.backgroundColor = UIColor.hexColor(color)
        }
        
        if let profitPercent = program.statistic?.profitPercent {
            cell.profitPercentLabel.text = profitPercent.rounded(toPlaces: 2).toString() + "%"
        }
        
        if let profitValue = program.statistic?.profitValue {
            cell.profitValueLabel.text = profitValue.rounded(withType: .gvt).toString() + " \(Constants.gvtString)"
        }
        
        if let isInvested = program.personalDetails?.isInvested {
            cell.investedImageView.isHidden = !isInvested
        }
    }
}
