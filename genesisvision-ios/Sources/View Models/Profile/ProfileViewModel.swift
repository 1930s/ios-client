//
//  ProfileViewModel.swift
//  genesisvision-ios
//
//  Created by George Shaginyan on 25.01.18.
//  Copyright © 2018 Genesis Vision. All rights reserved.
//

import UIKit

enum ProfileFieldType: String, EnumCollection {
    case email = "Email"
    
    case firstName = "First Name"
    case middleName = "Middle Name"
    case lastName = "Last Name"
    
    case birthday = "Birthday"
    case gender = "Gender"
}

enum ProfileState {
    case show
    case edit
}

final class ProfileViewModel {
    
    enum SectionType {
        case header
        case fields
    }
    
    // MARK: - Variables
    var title: String = "Profile"
    
    private var router: ProfileRouter!
    private var profileModel: ProfileFullViewModel?
    weak var textFieldDelegate: UITextFieldDelegate?
    
    var rows: [ProfileFieldType] = [.email, .firstName, .middleName, .lastName, .birthday, .gender]
    
    var editableFields = [EditableField]()
    var pickedImage: UIImage?
    var pickedImageURL: URL?
    
    class EditableField {
        var text: String
        var type: ProfileFieldType
        var placeholder: String
        var editable: Bool
        var selectable: Bool
        var keyboardType: UIKeyboardType?
        var textContentType: UITextContentType?
        
        var isValid: (String) -> Bool
        
        init(text: String, placeholder: String, editable: Bool, selectable: Bool, type: ProfileFieldType, keyboardType: UIKeyboardType?, textContentType: UITextContentType?, isValid: @escaping (String) -> Bool) {
            self.text = text
            self.placeholder = placeholder
            self.editable = editable
            self.selectable = selectable
            self.type = type
            self.keyboardType = keyboardType
            self.textContentType = textContentType
            self.isValid = isValid
        }
    }
    
    var sections: [SectionType] = [.fields]
    var profileState: ProfileState = .show {
        didSet {
            guard editableFields.count > 0 else { return }
            
            for idx in 0...editableFields.count - 1 {
                editableFields[idx].editable = getEditable(for: editableFields[idx].type)
                editableFields[idx].selectable = getSelectable(for: editableFields[idx].type)
            }
        }
    }
    
    weak var delegate: ProfileHeaderViewDelegate?
    
    /// Return view models for registration cell Nib files
    static var cellModelsForRegistration: [CellViewAnyModel.Type] {
        return [ProfileFieldTableViewCellViewModel.self]
    }
    
    // MARK: - Init
    init(withRouter router: ProfileRouter, profileModel: ProfileFullViewModel, textFieldDelegate: UITextFieldDelegate) {
        self.router = router
        self.textFieldDelegate = textFieldDelegate
        self.profileModel = profileModel
        
        setupCellViewModel()
    }
    
    // MARK: - Public methods
    func fetchProfile(completion: @escaping CompletionBlock) {
        AuthManager.getProfile(completion: { [weak self] (viewModel) in
            if let profileModel = viewModel {
                self?.profileModel = profileModel
                completion(.success)
            }
            
            completion(.failure(errorType: .apiError(message: nil)))
        }, completionError: completion)
    }
    
    func getAvatarURL() -> URL? {
        guard let avatar = profileModel?.avatar,
            let avatarURL = getFileURL(fileName: avatar)
            else { return nil }
        
        return avatarURL
    }
    
    // MARK: - TableView
    func numberOfSections() -> Int {
        return profileModel != nil ? sections.count : 0
    }
    
    func numberOfRows(in section: Int) -> Int {
        switch sections[section] {
        case .header:
            return 1
        case .fields:
            return editableFields.count
        }
    }
    
    func model(at indexPath: IndexPath) -> CellViewAnyModel? {
        let type = sections[indexPath.section]
        switch type {
        case .header:
            return nil
        case .fields:
            let field = editableFields[indexPath.row]
            return ProfileFieldTableViewCellViewModel(text: field.text, placeholder: field.placeholder, editable: field.editable, selectable: field.selectable, keyboardType: field.keyboardType, textContentType: field.textContentType, delegate: textFieldDelegate, valueChanged: { [weak self] (text) in
                let type: ProfileFieldType = ProfileFieldType(rawValue: field.placeholder)!
                switch type {
                case .firstName:
                    self?.profileModel?.firstName = text
                case .middleName:
                    self?.profileModel?.middleName = text
                case .lastName:
                    self?.profileModel?.lastName = text
                default:
                    break
                }
            })
            
        }
    }
    
    func editProfile(completion: @escaping CompletionBlock) {
        profileState = .edit
        completion(.success)
    }
    
    
    func cancelEditProfile(completion: @escaping CompletionBlock) {
        setupCellViewModel()
        profileState = .show
        fetchProfile(completion: completion)
    }
    
    func saveProfile(completion: @escaping CompletionBlock) {
        saveProfileApi(completion: completion)
    }

    func update(birthdate: Date?) {
        if let idx = editableFields.index(where: { $0.type == .birthday }) {
            guard let birthdate = birthdate else {
                editableFields[idx].text = ""
                return
            }
            
            profileModel?.birthday = birthdate
            editableFields[idx].text = birthdate.onlyDateFormatString
        }
    }
    
    func update(gender: Bool?) {
        if let idx = editableFields.index(where: { $0.type == .gender }) {
            guard let gender = gender else {
                editableFields[idx].text = ""
                return
            }
            
            profileModel?.gender = gender
            editableFields[idx].text = gender ? "Male" : "Female"
        }
    }
    
    func didSelect(_ indexPath: IndexPath) -> ProfileFieldType? {
        guard profileState == .edit else {
            return nil
        }
        
        let fieldType = rows[indexPath.row]
        
        switch fieldType {
        case .gender, .birthday:
            return fieldType
        default:
            return nil
        }
    }
    
    // MARK: -  Private methods
    private func getFields() -> [ProfileFieldType : String] {
        return [.email : profileModel?.email ?? "",
                .firstName : profileModel?.firstName ?? "",
                .middleName : profileModel?.middleName ?? "",
                .lastName : profileModel?.lastName ?? "",
                .birthday : getBirthday(),
                .gender : getGenderValue()]
    }
    
    private func getKeyboardTypes(for fieldType: ProfileFieldType) -> UIKeyboardType {
        switch fieldType {
        case .email:
            return .emailAddress
        default:
            return .default
        }
    }
    
    private func getTextContentTypes(for fieldType: ProfileFieldType) -> UITextContentType? {
        switch fieldType {
        case .firstName:
            return .name
        case .middleName:
            return .middleName
        case .lastName:
            return .familyName
        default:
            return nil
        }
    }
    
    private func getEditable(for fieldType: ProfileFieldType) -> Bool {
        guard profileState == .edit else {
            return false
        }
        
        switch fieldType {
        case .gender, .birthday, .email:
            return false
        default:
            return true
        }
    }
    
    private func getSelectable(for fieldType: ProfileFieldType) -> Bool {
        guard profileState == .edit else {
            return false
        }
        
        switch fieldType {
        case .gender, .birthday:
            return true
        default:
            return false
        }
    }
    
    private func setupCellViewModel() {
        var editableFields: [EditableField] = []
        
        ProfileFieldType.allValues.forEach { (type) in
            let fields = getFields()
            let key = type.rawValue
            
            let text = fields[type] ?? ""
            let placeholder = key.capitalized
            let editable = getEditable(for: type)
            let selectable = getSelectable(for: type)
            let keyboardType = getKeyboardTypes(for: type)
            let textContentType = getTextContentTypes(for: type)
            
            let editableField = EditableField(text: text, placeholder: placeholder, editable: editable, selectable: selectable, type: type, keyboardType: keyboardType, textContentType: textContentType, isValid: { (text) -> Bool in
                return text.count > 1
            })
            
            editableFields.append(editableField)
        }
        
        self.editableFields = editableFields
    }
    
    var fullName: String {
        guard let firstName = profileModel?.firstName, let lastName = profileModel?.lastName else { return String.placeholder }
        return firstName + " " + lastName
    }
    
    func getBirthday() -> String {
        guard let date = profileModel?.birthday else { return "" }
        
        return date.onlyDateFormatString
    }
    
    func getBirthdate() -> Date? {
        guard let date = profileModel?.birthday else { return nil }
        
        return date
    }
    
    func getGender() -> Bool? {
        guard let gender = profileModel?.gender else { return nil }
        
        return gender
    }
    
    func getGenderValue() -> String {
        guard let gender = profileModel?.gender else { return "" }
        
        return gender ? "Male" : "Female"
    }
    
    private func saveProfileApi(completion: @escaping CompletionBlock) {
        guard let pickedImageURL = pickedImageURL else {
            self.updateProfileApi(completion: completion)
            return 
        }
        
        ProfileDataProvider.updateProfileImage(imageURL: pickedImageURL, completion: { [weak self] (imageID) in
            self?.profileModel?.avatar = imageID
            self?.updateProfileApi(completion: completion)
        }, errorCompletion: completion)
    }
    
    private func updateProfileApi(completion: @escaping CompletionBlock) {
        guard let profileModel = profileModel else { return completion(.failure(errorType: .apiError(message: nil))) }
        
        let model = UpdateProfileViewModel(userName: profileModel.userName,
                                           firstName: profileModel.firstName,
                                           middleName: profileModel.middleName,
                                           lastName: profileModel.lastName,
                                           documentType: profileModel.documentType,
                                           documentNumber: profileModel.documentNumber,
                                           country: profileModel.country,
                                           city: profileModel.city,
                                           address: profileModel.address,
                                           phone: profileModel.phone,
                                           birthday: profileModel.birthday,
                                           gender: profileModel.gender,
                                           avatar: profileModel.avatar)
        
        ProfileDataProvider.updateProfile(model: model) { [weak self] (result) in
            switch result {
            case .success:
                AuthManager.saveProfileViewModel(viewModel: profileModel)
                self?.setupCellViewModel()
                self?.profileState = .show
            case .failure( _):
                break
            }
            
            completion(result)
        }
    }
    
    
}
