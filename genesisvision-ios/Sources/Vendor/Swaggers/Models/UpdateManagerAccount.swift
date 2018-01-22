//
// UpdateManagerAccount.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class UpdateManagerAccount: Codable {

    public var managerAccountId: UUID?
    public var name: String?
    public var description: String?
    public var avatar: String?


    
    public init(managerAccountId: UUID?, name: String?, description: String?, avatar: String?) {
        self.managerAccountId = managerAccountId
        self.name = name
        self.description = description
        self.avatar = avatar
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(managerAccountId, forKey: "managerAccountId")
        try container.encodeIfPresent(name, forKey: "name")
        try container.encodeIfPresent(description, forKey: "description")
        try container.encodeIfPresent(avatar, forKey: "avatar")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        managerAccountId = try container.decodeIfPresent(UUID.self, forKey: "managerAccountId")
        name = try container.decodeIfPresent(String.self, forKey: "name")
        description = try container.decodeIfPresent(String.self, forKey: "description")
        avatar = try container.decodeIfPresent(String.self, forKey: "avatar")
    }
}

