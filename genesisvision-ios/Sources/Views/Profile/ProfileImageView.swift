//
//  ProfileImageView.swift
//  genesisvision-ios
//
//  Created by George Shaginyan on 26.01.18.
//  Copyright © 2018 Genesis Vision. All rights reserved.
//

import UIKit.UIView

class ProfileImageView: UIView {
    @IBOutlet var profilePhotoImageView: UIImageView! {
        didSet {
            profilePhotoImageView.contentMode = .scaleAspectFill
            profilePhotoImageView.clipsToBounds = true
            profilePhotoImageView.image = UIImage.placeholder
            profilePhotoImageView.roundCorners(with: Constants.SystemSizes.cornerSize)
        }
    }
    
    @IBOutlet var readMoreImageView: UIImageView! {
        didSet {
            readMoreImageView.image = #imageLiteral(resourceName: "img_program_read_more")
            readMoreImageView.isHidden = true
        }
    }
    
    @IBOutlet var levelLabel: UILabel! {
        didSet {
            levelLabel.backgroundColor = .clear
            levelLabel.textColor = UIColor.Font.white
            levelLabel.layer.backgroundColor = UIColor.Cell.blue.cgColor
            levelLabel.roundWithBorder(3.0, color: UIColor.Cell.bg)
            levelLabel.font = UIFont.getFont(.bold, size: 15)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
