//
//  MarkerView.swift
//  genesisvision-ios
//
//  Created by George on 25/04/2018.
//  Copyright © 2018 Genesis Vision. All rights reserved.
//

import UIKit.UIView

class MarkerView: UIView {
    var cornerSize: CGFloat = 6.0
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("MarkerView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.layer.cornerRadius = cornerSize
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
