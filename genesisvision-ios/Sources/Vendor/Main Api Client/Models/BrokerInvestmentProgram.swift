//
// BrokerInvestmentProgram.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class BrokerInvestmentProgram: Codable {

    public var id: UUID?
    public var managerAccountId: UUID?
    public var dateFrom: Date?
    public var dateTo: Date?
    public var description: String?
    public var isEnabled: Bool?
    public var period: Int?
    public var feeSuccess: Double?
    public var feeManagement: Double?
    public var feeEntrance: Double?
    public var investMinAmount: Double?
    public var investMaxAmount: Double?
    public var lastPeriod: Period?
    public var login: String?
    public var ipfsHash: String?
    public var tradeIpfsHash: String?


    
    public init(id: UUID?, managerAccountId: UUID?, dateFrom: Date?, dateTo: Date?, description: String?, isEnabled: Bool?, period: Int?, feeSuccess: Double?, feeManagement: Double?, feeEntrance: Double?, investMinAmount: Double?, investMaxAmount: Double?, lastPeriod: Period?, login: String?, ipfsHash: String?, tradeIpfsHash: String?) {
        self.id = id
        self.managerAccountId = managerAccountId
        self.dateFrom = dateFrom
        self.dateTo = dateTo
        self.description = description
        self.isEnabled = isEnabled
        self.period = period
        self.feeSuccess = feeSuccess
        self.feeManagement = feeManagement
        self.feeEntrance = feeEntrance
        self.investMinAmount = investMinAmount
        self.investMaxAmount = investMaxAmount
        self.lastPeriod = lastPeriod
        self.login = login
        self.ipfsHash = ipfsHash
        self.tradeIpfsHash = tradeIpfsHash
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(id, forKey: "id")
        try container.encodeIfPresent(managerAccountId, forKey: "managerAccountId")
        try container.encodeIfPresent(dateFrom, forKey: "dateFrom")
        try container.encodeIfPresent(dateTo, forKey: "dateTo")
        try container.encodeIfPresent(description, forKey: "description")
        try container.encodeIfPresent(isEnabled, forKey: "isEnabled")
        try container.encodeIfPresent(period, forKey: "period")
        try container.encodeIfPresent(feeSuccess, forKey: "feeSuccess")
        try container.encodeIfPresent(feeManagement, forKey: "feeManagement")
        try container.encodeIfPresent(feeEntrance, forKey: "feeEntrance")
        try container.encodeIfPresent(investMinAmount, forKey: "investMinAmount")
        try container.encodeIfPresent(investMaxAmount, forKey: "investMaxAmount")
        try container.encodeIfPresent(lastPeriod, forKey: "lastPeriod")
        try container.encodeIfPresent(login, forKey: "login")
        try container.encodeIfPresent(ipfsHash, forKey: "ipfsHash")
        try container.encodeIfPresent(tradeIpfsHash, forKey: "tradeIpfsHash")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        id = try container.decodeIfPresent(UUID.self, forKey: "id")
        managerAccountId = try container.decodeIfPresent(UUID.self, forKey: "managerAccountId")
        dateFrom = try container.decodeIfPresent(Date.self, forKey: "dateFrom")
        dateTo = try container.decodeIfPresent(Date.self, forKey: "dateTo")
        description = try container.decodeIfPresent(String.self, forKey: "description")
        isEnabled = try container.decodeIfPresent(Bool.self, forKey: "isEnabled")
        period = try container.decodeIfPresent(Int.self, forKey: "period")
        feeSuccess = try container.decodeIfPresent(Double.self, forKey: "feeSuccess")
        feeManagement = try container.decodeIfPresent(Double.self, forKey: "feeManagement")
        feeEntrance = try container.decodeIfPresent(Double.self, forKey: "feeEntrance")
        investMinAmount = try container.decodeIfPresent(Double.self, forKey: "investMinAmount")
        investMaxAmount = try container.decodeIfPresent(Double.self, forKey: "investMaxAmount")
        lastPeriod = try container.decodeIfPresent(Period.self, forKey: "lastPeriod")
        login = try container.decodeIfPresent(String.self, forKey: "login")
        ipfsHash = try container.decodeIfPresent(String.self, forKey: "ipfsHash")
        tradeIpfsHash = try container.decodeIfPresent(String.self, forKey: "tradeIpfsHash")
    }
}

