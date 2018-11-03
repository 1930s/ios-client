//
//  SignUpViewController.swift
//  genesisvision-ios
//
//  Created by George Shaginyan on 18.01.18.
//  Copyright © 2018 Genesis Vision. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class SignUpViewController: BaseViewController {

    var viewModel: AuthSignUpViewModel!
    
    // MARK: - Outlets
    @IBOutlet var usernameStackView: UIStackView! {
        didSet {
            usernameStackView.isHidden = isInvestorApp
        }
    }
    
    @IBOutlet var usernameTitleLabel: SubtitleLabel! {
        didSet {
            usernameTitleLabel.text = "Username"
        }
    }
    @IBOutlet var usernameTextField: DesignableUITextField! {
        didSet {
            usernameTextField.setClearButtonWhileEditing()
            usernameTextField.delegate = self
        }
    }
    @IBOutlet var emailTitleLabel: SubtitleLabel! {
        didSet {
            emailTitleLabel.text = "Email"
        }
    }
    @IBOutlet var emailTextField: DesignableUITextField! {
        didSet {
            emailTextField.setClearButtonWhileEditing()
            emailTextField.delegate = self
        }
    }
    @IBOutlet var passwordTitleLabel: SubtitleLabel! {
        didSet {
            passwordTitleLabel.text = "Password"
        }
    }
    @IBOutlet var passwordTextField: DesignableUITextField! {
        didSet {
            passwordTextField.setClearButtonWhileEditing()
            passwordTextField.delegate = self
        }
    }
    @IBOutlet var confirmTitleLabel: SubtitleLabel! {
        didSet {
            confirmTitleLabel.text = "Confirm password"
        }
    }
    @IBOutlet var confirmPasswordTextField: DesignableUITextField! {
        didSet {
            confirmPasswordTextField.setClearButtonWhileEditing()
            confirmPasswordTextField.delegate = self
        }
    }
    
    // MARK: - Buttons
    @IBOutlet var privacyPolicyButton: UIButton! {
        didSet {
            privacyPolicyButton.tintColor = UIColor.Cell.title
            privacyPolicyButton.setTitleColor(UIColor.Cell.title, for: .normal)
            privacyPolicyButton.titleLabel?.font = UIFont.getFont(.regular, size: 12.0)
            privacyPolicyButton.setTitle("I accept the Privacy Policy", for: .normal)
        }
    }
    @IBOutlet var termsButton: UIButton! {
        didSet {
            termsButton.tintColor = UIColor.Cell.title
            termsButton.setTitleColor(UIColor.Cell.title, for: .normal)
            termsButton.titleLabel?.font = UIFont.getFont(.regular, size: 12.0)
            termsButton.setTitle("I accept the Terms of Service", for: .normal)
        }
    }
    @IBOutlet var notAmericanLabel: SubtitleLabel! {
        didSet {
            notAmericanLabel.textColor = UIColor.Cell.title
            notAmericanLabel.text = "I certify that I am not a resident or citizen of the USA"
        }
    }
    
    @IBOutlet var privacyPolicySwitchButton: UIButton! {
        didSet {
            privacyPolicySwitchButton.setImage(#imageLiteral(resourceName: "img_checkbox_unselected_icon"), for: .normal)
            privacyPolicySwitchButton.setImage(#imageLiteral(resourceName: "img_checkbox_selected_icon"), for: .selected)
        }
    }
    @IBOutlet var termsSwitchButton: UIButton! {
        didSet {
            termsSwitchButton.setImage(#imageLiteral(resourceName: "img_checkbox_unselected_icon"), for: .normal)
            termsSwitchButton.setImage(#imageLiteral(resourceName: "img_checkbox_selected_icon"), for: .selected)
        }
    }
    @IBOutlet var notAmericanSwitchButton: UIButton! {
        didSet {
            notAmericanSwitchButton.setImage(#imageLiteral(resourceName: "img_checkbox_unselected_icon"), for: .normal)
            notAmericanSwitchButton.setImage(#imageLiteral(resourceName: "img_checkbox_selected_icon"), for: .selected)
        }
    }
    
    @IBOutlet var signUpButton: ActionButton! {
        didSet {
            signUpButton.setEnabled(false)
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = viewModel.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        #if DEBUG
            if isInvestorApp {
                usernameTextField.text = ""
                emailTextField.text = "george@genesis.vision"
                passwordTextField.text = "qwerty"
                confirmPasswordTextField.text = "qwerty"
            } else {
                usernameTextField.text = "George"
                emailTextField.text = "george+1@genesis.vision"
                passwordTextField.text = "qwerty"
                confirmPasswordTextField.text = "qwerty"
            }
        #endif
        
        setupUI()
    }

    // MARK: - Private methods
    private func setupUI() {
        
    }
    
    
    private func sighUpMethod() {
        hideKeyboard()
        showProgressHUD()
        
        var username = usernameTextField.text ?? ""
        var email = emailTextField.text ?? ""
        var password = passwordTextField.text ?? ""
        var confirmPassword = confirmPasswordTextField.text ?? ""
        
        username = username.trimmingCharacters(in: .whitespaces)
        email = email.trimmingCharacters(in: .whitespaces)
        password = password.trimmingCharacters(in: .whitespaces)
        confirmPassword = confirmPassword.trimmingCharacters(in: .whitespaces)
        
        viewModel.signUp(username: username, email: email, password: password, confirmPassword: confirmPassword) { [weak self] (result) in
            self?.hideAll()
            
            switch result {
            case .success:
                self?.showSignUpInfoVC()
            case .failure(let errorType):
                ErrorHandler.handleError(with: errorType, viewController: self, hud: true)
            }
        }
    }
    
    private func showSignUpInfoVC() {
        showBottomSheet(type: .success, title: viewModel.successText) { [weak self] (success) in
            self?.viewModel.goToBack()
        }
    }
    
    // MARK: - Actions
    @IBAction func signUpButtonAction(_ sender: UIButton) {
        sighUpMethod()
    }
    
    @IBAction func showPrivacyButtonAction(_ sender: UIButton) {
        viewModel.showPrivacy()
    }
    
    @IBAction func showTermsButtonAction(_ sender: UIButton) {
        viewModel.showTerms()
    }
    
    @IBAction func switchButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        signUpButton.setEnabled(privacyPolicySwitchButton.isSelected && termsSwitchButton.isSelected && notAmericanSwitchButton.isSelected)
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case confirmPasswordTextField:
            sighUpMethod()
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            confirmPasswordTextField.becomeFirstResponder()
        default:
            IQKeyboardManager.sharedManager().goNext()
        }
        
        return false
    }
}
