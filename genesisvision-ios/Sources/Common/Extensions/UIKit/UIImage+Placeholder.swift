//
//  UIImage+Placeholder.swift
//  genesisvision-ios
//
//  Created by George Shaginyan on 04.02.18.
//  Copyright © 2018 Genesis Vision. All rights reserved.
//

import UIKit.UIImage

extension UIImage {
    static var placeholder: UIImage =  #imageLiteral(resourceName: "img_logo")
    static var noDataPlaceholder: UIImage = #imageLiteral(resourceName: "img_full_splash_logo")
    
    struct NavBar {
        static var ipfsList: UIImage = #imageLiteral(resourceName: "img_ipfs_list")
    }

    func alpha(_ value: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

