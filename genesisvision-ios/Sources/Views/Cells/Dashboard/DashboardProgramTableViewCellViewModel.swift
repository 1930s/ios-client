//
//  DashboardProgramTableViewCellViewModel.swift
//  genesisvision-ios
//
//  Created by George Shaginyan on 27.02.18.
//  Copyright © 2018 Genesis Vision. All rights reserved.
//

import Foundation
import Kingfisher

struct DashboardProgramTableViewCellViewModel {
    let program: ProgramDetails
    weak var reloadDataProtocol: ReloadDataProtocol?
    weak var delegate: FavoriteStateChangeProtocol?
}

extension DashboardProgramTableViewCellViewModel: CellViewModel {
    func setup(on cell: ProgramTableViewCell) {
        cell.dashboardBottomStackView.isHidden = false
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
            cell.titleLabel.text = title
        }
        
        if let managerName = program.manager?.username {
            cell.managerNameLabel.text = "by " + managerName
        }
        
        if let status = program.personalDetails?.status {
            cell.statusButton.setTitle(status.rawValue, for: .normal)
            cell.statusButton.layoutSubviews()
        }
        
        if let programId = program.id?.uuidString {
            cell.assetId = programId
        }
        
        if let level = program.level {
            cell.assetLogoImageView.levelButton.setTitle(level.toString(), for: .normal)
        }
        
        if let currency = program.currency {
            cell.currencyLabel.text = currency.rawValue
        }
        
        cell.firstTitleLabel.text = "Time left"
        if let periodEnds = program.periodEnds, let periodDuration = program.periodDuration {
            
            let today = Date()
            let periodLeft = periodEnds.timeSinceDate(fromDate: today)
            
            cell.firstValueLabel.text = periodLeft.isEmpty ? "0" : periodLeft
            
            if let minutes = periodEnds.getDateComponents(ofComponent: Calendar.Component.minute, fromDate: today).minute {
                cell.periodLeftProgressView.setProgress(to: Double(periodDuration - minutes) / Double(periodDuration), withAnimation: false)
            }
        } else {
            cell.firstValueLabel.text = ""
        }
        
        cell.secondTitleLabel.text = "Current value"
        if let balance = program.statistic?.balanceGVT, let balanceCurrency = balance.currency, let amount = balance.amount, let currency = CurrencyType(rawValue: balanceCurrency.rawValue) {
            cell.secondValueLabel.text = amount.rounded(withType: currency).toString() + " " + currency.rawValue
        } else {
            cell.secondValueLabel.text = ""
        }
        
        cell.thirdTitleLabel.text = "Share"
        if let share = program.dashboardAssetsDetails?.share {
            cell.thirdValueLabel.text = share.rounded(withType: .undefined).toString() + "%"
        } else {
            cell.thirdValueLabel.text = ""
        }
        
        if let isFavorite = program.personalDetails?.isFavorite {
            cell.favoriteButton.isSelected = isFavorite
        }
        
        cell.assetLogoImageView.profilePhotoImageView.image = UIImage.programPlaceholder
        
        if let logo = program.logo, let fileUrl = getFileURL(fileName: logo) {
            cell.assetLogoImageView.profilePhotoImageView.kf.indicatorType = .activity
            cell.assetLogoImageView.profilePhotoImageView.kf.setImage(with: fileUrl, placeholder: UIImage.programPlaceholder)
        }
        
        if let color = program.color {
            cell.assetLogoImageView.profilePhotoImageView.backgroundColor = UIColor.hexColor(color)
        }
        
        if let profitPercent = program.statistic?.profitPercent {
            cell.profitPercentLabel.text = profitPercent.rounded(withType: .undefined).toString() + "%"
        }
        
        if let profitValue = program.statistic?.profitValue {
            cell.profitValueLabel.text = profitValue.rounded(withType: .gvt).toString() + " \(Constants.gvtString)"
        }
        
        if let isInvested = program.personalDetails?.isInvested {
            cell.investedImageView.isHidden = !isInvested
        }
    }
}