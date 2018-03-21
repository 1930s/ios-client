//
//  DetailHeaderTableViewCell.swift
//  genesisvision-ios
//
//  Created by George Shaginyan on 11.02.18.
//  Copyright © 2018 Genesis Vision. All rights reserved.
//

import UIKit

class DetailHeaderTableViewCell: UITableViewCell {

    // MARK: - Views
    @IBOutlet var programLogoImageView: ProfileImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var managerLabel: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.backgroundColor = UIColor.Background.main
        selectionStyle = .none
    }
}
