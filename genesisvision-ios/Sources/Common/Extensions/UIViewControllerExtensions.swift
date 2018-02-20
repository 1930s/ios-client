//
//  UIViewControllerExtensions.swift
//  genesisvision-ios
//
//  Created by George Shaginyan on 16.01.18.
//  Copyright © 2018 Genesis Vision. All rights reserved.
//

import SafariServices
import UIKit.UIViewController
import PKHUD

extension UIViewController {
    
    // MARK: - Stroryboard Instances
    enum StoryboardNames: String {
        case main
        case launch
        case profile
        case traders
        case auth
        case wallet
        case dashboard
        case tournament
    }
    
    private class func mainStoryboardInstancePrivate<T: UIViewController>(name: String) -> T? {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? T
    }
    
    class func storyboardInstance(name: StoryboardNames) -> Self? {
        return mainStoryboardInstancePrivate(name: name.rawValue.capitalized)
    }
    
    
    // MARK: - Alerts
    func showAlertWithTitle(title: String?, message: String, actionTitle: String?, cancelTitle: String?, handler: (() -> Void)?, cancelHandler: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if actionTitle != nil {
            let action = UIAlertAction(title: actionTitle, style: .default) { (UIAlertAction) in
                if handler != nil {
                    handler!()
                }
            }
            alert.addAction(action)
        }
        
        if cancelTitle != nil {
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { (UIAlertAction) in
                if cancelHandler != nil {
                    cancelHandler!()
                }
            }
            alert.addAction(cancelAction)
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    func showSettingsAlert(_ message: String) {
        let alert = UIAlertController(title: "Privacy settings", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            
            if let url = NSURL(string: UIApplicationOpenSettingsURLString) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url as URL)
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithDelay(text: String?, delay: Double, didShowed: (() -> Swift.Void)?) {
        let alertController = UIAlertController(title: nil, message: text, preferredStyle: .alert)
        present(alertController, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            alertController.dismiss(animated: true, completion: {
                if didShowed != nil {
                    didShowed!()
                }
            })
        }
    }

    // MARK: - PKHUD
    func showProgressHUD() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        HUD.show(.progress, onView: self.view)
    }

    func hideHUD() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        HUD.hide()
    }

    func showErrorHUD(title: String?, subtitle: String?) {
        if title != nil || subtitle != nil {
            HUD.flash(.labeledError(title: title, subtitle: subtitle), delay: 1.0)
        } else {
            HUD.flash(.error, delay: 1.0)
        }
    }
    
    func showErrorHUD(subtitle: String?) {
        if subtitle != nil {
            HUD.flash(.labeledError(title: nil, subtitle: subtitle), delay: 1.0)
        } else {
            HUD.flash(.error, delay: 1.0)
        }
    }

    func showSuccessHUD(title: String?, subtitle: String?) {
        if title != nil || subtitle != nil {
            HUD.flash(.labeledSuccess(title: title, subtitle: subtitle), delay: 2.0)
        } else {
            HUD.flash(.success, delay: 1.0)
        }
    }

    func showSuccessHUD() {
        HUD.show(.success)
    }
    
    func showSuccessHUD(completion: ((Bool) -> Void)? = nil) {
        HUD.flash(.success, onView: nil, delay: 1.0, completion: completion)
    }

    func showHUD(type: HUDContentType) {
        HUD.show(.success)
    }

    func showFlashHUD(type: HUDContentType, delay: TimeInterval?) {
        if delay != nil {
            HUD.flash(type, delay: delay!)
        } else {
            HUD.flash(type, delay: 1.0)
        }
    }
    
    // MARK: - Keyboard
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Navigation
    func present(viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
    
    func push(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func open(url: URL) {
        let safariViewController = SFSafariViewController(url: url, entersReaderIfAvailable: false)
        safariViewController.preferredBarTintColor = UIColor.Background.gray
        safariViewController.preferredControlTintColor = UIColor.primary
        if #available(iOS 11.0, *) {
            safariViewController.dismissButtonStyle = .close
        }
        safariViewController.modalPresentationStyle = .overFullScreen
        present(viewController: safariViewController)
    }
}
