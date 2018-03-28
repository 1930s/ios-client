//
// ManagerProfitChartData.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class ManagerProfitChartData: Codable {

    public var date: Date?
    public var totalProfit: Double?


    
    public init(date: Date?, totalProfit: Double?) {
        self.date = date
        self.totalProfit = totalProfit
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(date, forKey: "date")
        try container.encodeIfPresent(totalProfit, forKey: "totalProfit")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        date = try container.decodeIfPresent(Date.self, forKey: "date")
        totalProfit = try container.decodeIfPresent(Double.self, forKey: "totalProfit")
    }
}
