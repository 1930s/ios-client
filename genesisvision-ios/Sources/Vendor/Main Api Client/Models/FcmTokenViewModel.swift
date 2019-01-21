//
// FcmTokenViewModel.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class FcmTokenViewModel: Codable {

    public var token: String


    
    public init(token: String) {
        self.token = token
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encode(token, forKey: "token")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        token = try container.decode(String.self, forKey: "token")
    }
}

