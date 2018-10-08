//
// RateItem.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class RateItem: Codable {

    public enum Currency: String, Codable { 
        case undefined = "Undefined"
        case gvt = "GVT"
        case eth = "ETH"
        case btc = "BTC"
        case ada = "ADA"
        case usd = "USD"
        case eur = "EUR"
    }
    public var currency: Currency?
    public var rate: Double?


    
    public init(currency: Currency?, rate: Double?) {
        self.currency = currency
        self.rate = rate
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(currency, forKey: "currency")
        try container.encodeIfPresent(rate, forKey: "rate")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        currency = try container.decodeIfPresent(Currency.self, forKey: "currency")
        rate = try container.decodeIfPresent(Double.self, forKey: "rate")
    }
}

