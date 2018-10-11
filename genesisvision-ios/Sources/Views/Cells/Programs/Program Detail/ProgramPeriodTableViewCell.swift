//
//  ProgramPeriodTableViewCell.swift
//  genesisvision-ios
//
//  Created by George on 01/10/2018.
//  Copyright © 2018 Genesis Vision. All rights reserved.
//

import UIKit

class ProgramPeriodTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet var progressView: UIProgressView! {
        didSet {
            progressView.progressTintColor = UIColor.ProgressView.progressTint
            progressView.trackTintColor = UIColor.ProgressView.trackTint
        }
    }
    @IBOutlet var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = UIColor.Cell.subtitle
            titleLabel.font = UIFont.getFont(.semibold, size: 14.0)
        }
    }
    @IBOutlet var durationLabel: UILabel! {
        didSet {
            durationLabel.textColor = UIColor.Cell.title
            durationLabel.font = UIFont.getFont(.semibold, size: 14.0)
        }
    }
    @IBOutlet var periodLeftLabel: UILabel! {
        didSet {
            periodLeftLabel.textColor = UIColor.Cell.title
            periodLeftLabel.font = UIFont.getFont(.semibold, size: 14.0)
        }
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.BaseView.bg
        contentView.backgroundColor = UIColor.BaseView.bg
        selectionStyle = .none
    }
}
