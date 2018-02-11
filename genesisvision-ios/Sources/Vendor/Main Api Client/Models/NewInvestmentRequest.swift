//
// NewInvestmentRequest.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class NewInvestmentRequest: Codable {

    public var brokerTradeServerId: UUID
    public var tradePlatformPassword: String
    public var depositAmount: Double
    public var tokenName: String
    public var tokenSymbol: String
    public var dateFrom: Date
    public var dateTo: Date
    public var logo: String?
    public var title: String
    public var description: String?
    public var feeEntrance: Double
    public var feeManagement: Double
    public var feeSuccess: Double
    public var investMinAmount: Double
    public var investMaxAmount: Double
    public var period: Int


    
    public init(brokerTradeServerId: UUID, tradePlatformPassword: String, depositAmount: Double, tokenName: String, tokenSymbol: String, dateFrom: Date, dateTo: Date, logo: String?, title: String, description: String?, feeEntrance: Double, feeManagement: Double, feeSuccess: Double, investMinAmount: Double, investMaxAmount: Double, period: Int) {
        self.brokerTradeServerId = brokerTradeServerId
        self.tradePlatformPassword = tradePlatformPassword
        self.depositAmount = depositAmount
        self.tokenName = tokenName
        self.tokenSymbol = tokenSymbol
        self.dateFrom = dateFrom
        self.dateTo = dateTo
        self.logo = logo
        self.title = title
        self.description = description
        self.feeEntrance = feeEntrance
        self.feeManagement = feeManagement
        self.feeSuccess = feeSuccess
        self.investMinAmount = investMinAmount
        self.investMaxAmount = investMaxAmount
        self.period = period
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encode(brokerTradeServerId, forKey: "brokerTradeServerId")
        try container.encode(tradePlatformPassword, forKey: "tradePlatformPassword")
        try container.encode(depositAmount, forKey: "depositAmount")
        try container.encode(tokenName, forKey: "tokenName")
        try container.encode(tokenSymbol, forKey: "tokenSymbol")
        try container.encode(dateFrom, forKey: "dateFrom")
        try container.encode(dateTo, forKey: "dateTo")
        try container.encodeIfPresent(logo, forKey: "logo")
        try container.encode(title, forKey: "title")
        try container.encodeIfPresent(description, forKey: "description")
        try container.encode(feeEntrance, forKey: "feeEntrance")
        try container.encode(feeManagement, forKey: "feeManagement")
        try container.encode(feeSuccess, forKey: "feeSuccess")
        try container.encode(investMinAmount, forKey: "investMinAmount")
        try container.encode(investMaxAmount, forKey: "investMaxAmount")
        try container.encode(period, forKey: "period")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        brokerTradeServerId = try container.decode(UUID.self, forKey: "brokerTradeServerId")
        tradePlatformPassword = try container.decode(String.self, forKey: "tradePlatformPassword")
        depositAmount = try container.decode(Double.self, forKey: "depositAmount")
        tokenName = try container.decode(String.self, forKey: "tokenName")
        tokenSymbol = try container.decode(String.self, forKey: "tokenSymbol")
        dateFrom = try container.decode(Date.self, forKey: "dateFrom")
        dateTo = try container.decode(Date.self, forKey: "dateTo")
        logo = try container.decodeIfPresent(String.self, forKey: "logo")
        title = try container.decode(String.self, forKey: "title")
        description = try container.decodeIfPresent(String.self, forKey: "description")
        feeEntrance = try container.decode(Double.self, forKey: "feeEntrance")
        feeManagement = try container.decode(Double.self, forKey: "feeManagement")
        feeSuccess = try container.decode(Double.self, forKey: "feeSuccess")
        investMinAmount = try container.decode(Double.self, forKey: "investMinAmount")
        investMaxAmount = try container.decode(Double.self, forKey: "investMaxAmount")
        period = try container.decode(Int.self, forKey: "period")
    }
}

