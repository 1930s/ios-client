//
// BrokerInitData.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class BrokerInitData: Codable {

    public var newManagerRequest: [ManagerRequest]?
    public var investments: [InvestmentProgram]?


    
    public init(newManagerRequest: [ManagerRequest]?, investments: [InvestmentProgram]?) {
        self.newManagerRequest = newManagerRequest
        self.investments = investments
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(newManagerRequest, forKey: "newManagerRequest")
        try container.encodeIfPresent(investments, forKey: "investments")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        newManagerRequest = try container.decodeIfPresent([ManagerRequest].self, forKey: "newManagerRequest")
        investments = try container.decodeIfPresent([InvestmentProgram].self, forKey: "investments")
    }
}

