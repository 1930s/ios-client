//
// FundAssetPartDetails.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class FundAssetPartDetails: Codable {

    public var name: String?
    public var symbol: String?
    public var assetPart: Double?


    
    public init(name: String?, symbol: String?, assetPart: Double?) {
        self.name = name
        self.symbol = symbol
        self.assetPart = assetPart
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(name, forKey: "name")
        try container.encodeIfPresent(symbol, forKey: "symbol")
        try container.encodeIfPresent(assetPart, forKey: "assetPart")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        name = try container.decodeIfPresent(String.self, forKey: "name")
        symbol = try container.decodeIfPresent(String.self, forKey: "symbol")
        assetPart = try container.decodeIfPresent(Double.self, forKey: "assetPart")
    }
}
