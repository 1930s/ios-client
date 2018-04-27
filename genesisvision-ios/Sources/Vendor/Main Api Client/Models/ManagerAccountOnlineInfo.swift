//
// ManagerAccountOnlineInfo.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class ManagerAccountOnlineInfo: Codable {

    public var managerId: UUID?
    public var balance: Double?
    public var equity: Double?


    
    public init(managerId: UUID?, balance: Double?, equity: Double?) {
        self.managerId = managerId
        self.balance = balance
        self.equity = equity
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(managerId, forKey: "managerId")
        try container.encodeIfPresent(balance, forKey: "balance")
        try container.encodeIfPresent(equity, forKey: "equity")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        managerId = try container.decodeIfPresent(UUID.self, forKey: "managerId")
        balance = try container.decodeIfPresent(Double.self, forKey: "balance")
        equity = try container.decodeIfPresent(Double.self, forKey: "equity")
    }
}
