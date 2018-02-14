//
//  UIImage+Placeholder.swift
//  genesisvision-ios
//
//  Created by George Shaginyan on 04.02.18.
//  Copyright © 2018 Genesis Vision. All rights reserved.
//

import UIKit.UIImage

extension UIImage {
    static var placeholder: UIImage {
        return #imageLiteral(resourceName: "gv_logo")
    }
    
    static var noDataPlaceholder: UIImage {
        return #imageLiteral(resourceName: "img_trader_nodata_placeholder")
    }
}
