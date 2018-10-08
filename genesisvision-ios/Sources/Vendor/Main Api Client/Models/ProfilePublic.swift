//
// ProfilePublic.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class ProfilePublic: Codable {

    public var id: UUID?
    public var username: String?
    public var avatar: String?
    public var registrationDate: Date?
    public var url: String?


    
    public init(id: UUID?, username: String?, avatar: String?, registrationDate: Date?, url: String?) {
        self.id = id
        self.username = username
        self.avatar = avatar
        self.registrationDate = registrationDate
        self.url = url
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(id, forKey: "id")
        try container.encodeIfPresent(username, forKey: "username")
        try container.encodeIfPresent(avatar, forKey: "avatar")
        try container.encodeIfPresent(registrationDate, forKey: "registrationDate")
        try container.encodeIfPresent(url, forKey: "url")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        id = try container.decodeIfPresent(UUID.self, forKey: "id")
        username = try container.decodeIfPresent(String.self, forKey: "username")
        avatar = try container.decodeIfPresent(String.self, forKey: "avatar")
        registrationDate = try container.decodeIfPresent(Date.self, forKey: "registrationDate")
        url = try container.decodeIfPresent(String.self, forKey: "url")
    }
}

