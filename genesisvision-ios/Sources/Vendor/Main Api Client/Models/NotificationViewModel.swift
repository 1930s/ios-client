//
// NotificationViewModel.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class NotificationViewModel: Codable {

    public enum ModelType: String, Codable { 
        case platformNewsAndUpdates = "PlatformNewsAndUpdates"
        case platformEmergency = "PlatformEmergency"
        case platformOther = "PlatformOther"
        case profileUpdated = "ProfileUpdated"
        case profilePwdUpdated = "ProfilePwdUpdated"
        case profileVerification = "ProfileVerification"
        case profile2FA = "Profile2FA"
        case profileSecurity = "ProfileSecurity"
        case programNewsAndUpdates = "ProgramNewsAndUpdates"
        case programEndOfPeriod = "ProgramEndOfPeriod"
        case programCondition = "ProgramCondition"
        case managerNewProgram = "ManagerNewProgram"
    }
    public var id: UUID?
    public var text: String?
    public var date: Date?
    public var type: ModelType?
    public var programId: UUID?
    public var managerId: UUID?
    public var logo: String?
    public var url: String?
    public var isUnread: Bool?


    
    public init(id: UUID?, text: String?, date: Date?, type: ModelType?, programId: UUID?, managerId: UUID?, logo: String?, url: String?, isUnread: Bool?) {
        self.id = id
        self.text = text
        self.date = date
        self.type = type
        self.programId = programId
        self.managerId = managerId
        self.logo = logo
        self.url = url
        self.isUnread = isUnread
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(id, forKey: "id")
        try container.encodeIfPresent(text, forKey: "text")
        try container.encodeIfPresent(date, forKey: "date")
        try container.encodeIfPresent(type, forKey: "type")
        try container.encodeIfPresent(programId, forKey: "programId")
        try container.encodeIfPresent(managerId, forKey: "managerId")
        try container.encodeIfPresent(logo, forKey: "logo")
        try container.encodeIfPresent(url, forKey: "url")
        try container.encodeIfPresent(isUnread, forKey: "isUnread")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        id = try container.decodeIfPresent(UUID.self, forKey: "id")
        text = try container.decodeIfPresent(String.self, forKey: "text")
        date = try container.decodeIfPresent(Date.self, forKey: "date")
        type = try container.decodeIfPresent(ModelType.self, forKey: "type")
        programId = try container.decodeIfPresent(UUID.self, forKey: "programId")
        managerId = try container.decodeIfPresent(UUID.self, forKey: "managerId")
        logo = try container.decodeIfPresent(String.self, forKey: "logo")
        url = try container.decodeIfPresent(String.self, forKey: "url")
        isUnread = try container.decodeIfPresent(Bool.self, forKey: "isUnread")
    }
}

