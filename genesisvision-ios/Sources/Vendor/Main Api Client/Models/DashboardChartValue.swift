//
// DashboardChartValue.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class DashboardChartValue: Codable {

    public var investedProgramsInfo: [ValueChartBar]?
    public var balanceChart: [ChartSimple]?
    public var value: Double?
    public var valueCurrency: Double?
    public var changePercent: Double?
    public var changeValue: Double?
    public var changeValueCurrency: Double?
    public var rate: Double?


    
    public init(investedProgramsInfo: [ValueChartBar]?, balanceChart: [ChartSimple]?, value: Double?, valueCurrency: Double?, changePercent: Double?, changeValue: Double?, changeValueCurrency: Double?, rate: Double?) {
        self.investedProgramsInfo = investedProgramsInfo
        self.balanceChart = balanceChart
        self.value = value
        self.valueCurrency = valueCurrency
        self.changePercent = changePercent
        self.changeValue = changeValue
        self.changeValueCurrency = changeValueCurrency
        self.rate = rate
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(investedProgramsInfo, forKey: "investedProgramsInfo")
        try container.encodeIfPresent(balanceChart, forKey: "balanceChart")
        try container.encodeIfPresent(value, forKey: "value")
        try container.encodeIfPresent(valueCurrency, forKey: "valueCurrency")
        try container.encodeIfPresent(changePercent, forKey: "changePercent")
        try container.encodeIfPresent(changeValue, forKey: "changeValue")
        try container.encodeIfPresent(changeValueCurrency, forKey: "changeValueCurrency")
        try container.encodeIfPresent(rate, forKey: "rate")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        investedProgramsInfo = try container.decodeIfPresent([ValueChartBar].self, forKey: "investedProgramsInfo")
        balanceChart = try container.decodeIfPresent([ChartSimple].self, forKey: "balanceChart")
        value = try container.decodeIfPresent(Double.self, forKey: "value")
        valueCurrency = try container.decodeIfPresent(Double.self, forKey: "valueCurrency")
        changePercent = try container.decodeIfPresent(Double.self, forKey: "changePercent")
        changeValue = try container.decodeIfPresent(Double.self, forKey: "changeValue")
        changeValueCurrency = try container.decodeIfPresent(Double.self, forKey: "changeValueCurrency")
        rate = try container.decodeIfPresent(Double.self, forKey: "rate")
    }
}
