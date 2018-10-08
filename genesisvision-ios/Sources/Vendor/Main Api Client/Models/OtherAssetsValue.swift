//
// OtherAssetsValue.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class OtherAssetsValue: Codable {

    public var amount: Int?
    public var value: Double?
    public var changePercent: Double?
    public var changeValue: Double?


    
    public init(amount: Int?, value: Double?, changePercent: Double?, changeValue: Double?) {
        self.amount = amount
        self.value = value
        self.changePercent = changePercent
        self.changeValue = changeValue
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(amount, forKey: "amount")
        try container.encodeIfPresent(value, forKey: "value")
        try container.encodeIfPresent(changePercent, forKey: "changePercent")
        try container.encodeIfPresent(changeValue, forKey: "changeValue")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        amount = try container.decodeIfPresent(Int.self, forKey: "amount")
        value = try container.decodeIfPresent(Double.self, forKey: "value")
        changePercent = try container.decodeIfPresent(Double.self, forKey: "changePercent")
        changeValue = try container.decodeIfPresent(Double.self, forKey: "changeValue")
    }
}

