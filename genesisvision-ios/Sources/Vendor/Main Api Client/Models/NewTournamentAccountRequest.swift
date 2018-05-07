//
// NewTournamentAccountRequest.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class NewTournamentAccountRequest: Codable {

    public var title: String
    public var description: String?
    public var logo: String?


    
    public init(title: String, description: String?, logo: String?) {
        self.title = title
        self.description = description
        self.logo = logo
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encode(title, forKey: "title")
        try container.encodeIfPresent(description, forKey: "description")
        try container.encodeIfPresent(logo, forKey: "logo")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        title = try container.decode(String.self, forKey: "title")
        description = try container.decodeIfPresent(String.self, forKey: "description")
        logo = try container.decodeIfPresent(String.self, forKey: "logo")
    }
}

