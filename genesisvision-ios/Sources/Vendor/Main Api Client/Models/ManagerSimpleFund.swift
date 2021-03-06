//
// ManagerSimpleFund.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class ManagerSimpleFund: Codable {

    public var id: UUID?
    public var title: String?
    public var color: String?
    public var logo: String?
    public var url: String?


    
    public init(id: UUID?, title: String?, color: String?, logo: String?, url: String?) {
        self.id = id
        self.title = title
        self.color = color
        self.logo = logo
        self.url = url
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(id, forKey: "id")
        try container.encodeIfPresent(title, forKey: "title")
        try container.encodeIfPresent(color, forKey: "color")
        try container.encodeIfPresent(logo, forKey: "logo")
        try container.encodeIfPresent(url, forKey: "url")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        id = try container.decodeIfPresent(UUID.self, forKey: "id")
        title = try container.decodeIfPresent(String.self, forKey: "title")
        color = try container.decodeIfPresent(String.self, forKey: "color")
        logo = try container.decodeIfPresent(String.self, forKey: "logo")
        url = try container.decodeIfPresent(String.self, forKey: "url")
    }
}

