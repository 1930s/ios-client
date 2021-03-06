//
//  ProgramHeaderViewController.swift
//  genesisvision-ios
//
//  Created by George on 28/09/2018.
//  Copyright © 2018 Genesis Vision. All rights reserved.
//

import UIKit
import Kingfisher

protocol ProgramHeaderViewControllerProtocol: class {
    func aboutLevelButtonDidPress()
}

class ProgramHeaderViewController: BaseViewController {
    // MARK: - Variables
    weak var delegate: ProgramHeaderViewControllerProtocol?
    
    @IBOutlet weak var activityIndicatorTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var titleBottomConstraint: NSLayoutConstraint! {
        didSet {
            titleBottomConstraint.constant = 20.0
        }
    }
    @IBOutlet weak var titleLeadingConstraint: NSLayoutConstraint! {
        didSet {
            titleLeadingConstraint.constant = 16.0
        }
    }
    @IBOutlet weak var titleTrailingConstraint: NSLayoutConstraint! {
        didSet {
            titleTrailingConstraint.constant = 16.0
        }
    }
    
    @IBOutlet weak var headerTitleImageView: UIImageView! {
        didSet {
            headerTitleImageView.alpha = 0.0
            headerTitleImageView.roundCorners(with: 6.0)
        }
    }
    
    @IBOutlet weak var investedImageView: UIImageView! {
        didSet {
            self.investedImageView.isHidden = true
        }
    }
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var gradientView: GradientView! {
        didSet {
            gradientView.colors = [UIColor.Cell.bg.withAlphaComponent(0.0).cgColor, UIColor.Cell.bg.cgColor]
            gradientView.backgroundColor = UIColor.Cell.bg.withAlphaComponent(0.0)
        }
    }
    
    @IBOutlet weak var labelsStackView: UIStackView!
    @IBOutlet weak var levelBgImageView: UIImageView!
    @IBOutlet weak var levelButton: LevelButton! {
        didSet {
            levelButton.borderSize = 0.0
        }
    }
    
    @IBOutlet weak var titleLabel: TitleLabel! {
        didSet {
            titleLabel.font = UIFont.getFont(.semibold, size: 26.0)
        }
    }
    @IBOutlet weak var currencyLabel: CurrencyLabel!
    @IBOutlet weak var ratingTagLabel: RoundedLabel! {
        didSet {
            ratingTagLabel.isHidden = true
            ratingTagLabel.text = "TOP 10%"
            ratingTagLabel.textColor = UIColor.Cell.ratingTagTitle
            ratingTagLabel.backgroundColor = UIColor.Cell.ratingTagBg
        }
    }
    
    @IBOutlet weak var labelsLeadingConstraint: NSLayoutConstraint!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.Cell.bg
        activityIndicator.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.levelButton.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }, completion: { _ in
            UIView.animate(withDuration: 0.3, animations: {
                self.levelButton.transform = CGAffineTransform.identity
            }, completion: { _ in
                self.levelButton.layoutSubviews()
            })
        })
    }
    
    // MARK: - Public methods
    func moveLabels(offset: CGFloat) {
        self.labelsLeadingConstraint.constant = 16.0 + offset
        
        if self.labelsLeadingConstraint.constant > 80.0 {
            self.labelsLeadingConstraint.constant = 80.0
        }
    }
    
    func changeColorAlpha(offset: CGFloat) {
        self.levelBgImageView.alpha = 1.0 - offset
        self.levelButton.alpha = 1.0 - offset
        self.bgImageView.alpha = 1.0 - offset
        self.currencyLabel.alpha = 1.0 - offset * 2
        self.ratingTagLabel.alpha = 1.0 - offset * 2
        self.investedImageView.alpha = 1.0 - offset * 2
        
        self.headerTitleImageView.alpha = offset
        
        self.titleLeadingConstraint.constant = 16.0 + offset * 50.0
        self.titleBottomConstraint.constant = 20.0 - offset * 46.0
        self.titleTrailingConstraint.constant = 16.0 + offset * 76.0
        
        self.titleLabel.font = UIFont.getFont(.semibold, size: 26.0 - 10.0 * offset)
        
        gradientView.backgroundColor = UIColor.Cell.bg.withAlphaComponent(offset)
    }
    
    func configure(_ programDetailsFull: ProgramDetailsFull?) {
        if let title = programDetailsFull?.title {
            titleLabel.text = title
        }
        
        if let currency = programDetailsFull?.currency {
            currencyLabel.text = currency.rawValue
        }
        
        if let level = programDetailsFull?.level {
            levelButton.setTitle(level.toString(), for: .normal)
        }
        
        bgImageView.image = UIImage.programPlaceholder
        headerTitleImageView.image = UIImage.programPlaceholder
        
        if let color = programDetailsFull?.color {
            bgImageView.backgroundColor = UIColor.hexColor(color)
            headerTitleImageView.backgroundColor = UIColor.hexColor(color)
        }
        
        if let logo = programDetailsFull?.logo, let fileUrl = getFileURL(fileName: logo) {
            bgImageView.kf.indicatorType = .activity
            headerTitleImageView.kf.indicatorType = .activity
            
            let resource = ImageResource(downloadURL: fileUrl, cacheKey: logo)
            bgImageView.kf.setImage(with: resource, placeholder: UIImage.programPlaceholder)
            headerTitleImageView.kf.setImage(with: resource, placeholder: UIImage.programPlaceholder)
        }
        
        if let isInvested = programDetailsFull?.personalProgramDetails?.isInvested {
            self.investedImageView.isHidden = !isInvested
        }
        
        if let rating = programDetailsFull?.rating, let canLevelUp = rating.canLevelUp {
            ratingTagLabel.isHidden = !canLevelUp
        }
    }
    
    // MARK: - Actions
    @IBAction func aboutLevelButtonAction(_ sender: UIButton) {
        delegate?.aboutLevelButtonDidPress()
    }
}
