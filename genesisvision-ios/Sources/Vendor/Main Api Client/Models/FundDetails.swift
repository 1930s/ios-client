//
// FundDetails.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class FundDetails: Codable {

    public enum Status: String, Codable { 
        case _none = "None"
        case pending = "Pending"
        case errorCreating = "ErrorCreating"
        case active = "Active"
        case closed = "Closed"
        case archived = "Archived"
        case closedDueToInactivity = "ClosedDueToInactivity"
    }
    public var totalAssetsCount: Int?
    public var topFundAssets: [FundAssetPercent]?
    public var statistic: FundDetailsListStatistic?
    /** Fields for authorized user */
    public var personalDetails: PersonalFundDetailsFull?
    public var id: UUID?
    public var logo: String?
    public var url: String?
    public var color: String?
    public var title: String?
    public var description: String?
    public var status: Status?
    public var manager: ProfilePublic?
    public var chart: [ChartSimple]?
    /** Fields for dashboard */
    public var dashboardAssetsDetails: DashboardProgramDetails?


    
    public init(totalAssetsCount: Int?, topFundAssets: [FundAssetPercent]?, statistic: FundDetailsListStatistic?, personalDetails: PersonalFundDetailsFull?, id: UUID?, logo: String?, url: String?, color: String?, title: String?, description: String?, status: Status?, manager: ProfilePublic?, chart: [ChartSimple]?, dashboardAssetsDetails: DashboardProgramDetails?) {
        self.totalAssetsCount = totalAssetsCount
        self.topFundAssets = topFundAssets
        self.statistic = statistic
        self.personalDetails = personalDetails
        self.id = id
        self.logo = logo
        self.url = url
        self.color = color
        self.title = title
        self.description = description
        self.status = status
        self.manager = manager
        self.chart = chart
        self.dashboardAssetsDetails = dashboardAssetsDetails
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(totalAssetsCount, forKey: "totalAssetsCount")
        try container.encodeIfPresent(topFundAssets, forKey: "topFundAssets")
        try container.encodeIfPresent(statistic, forKey: "statistic")
        try container.encodeIfPresent(personalDetails, forKey: "personalDetails")
        try container.encodeIfPresent(id, forKey: "id")
        try container.encodeIfPresent(logo, forKey: "logo")
        try container.encodeIfPresent(url, forKey: "url")
        try container.encodeIfPresent(color, forKey: "color")
        try container.encodeIfPresent(title, forKey: "title")
        try container.encodeIfPresent(description, forKey: "description")
        try container.encodeIfPresent(status, forKey: "status")
        try container.encodeIfPresent(manager, forKey: "manager")
        try container.encodeIfPresent(chart, forKey: "chart")
        try container.encodeIfPresent(dashboardAssetsDetails, forKey: "dashboardAssetsDetails")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        totalAssetsCount = try container.decodeIfPresent(Int.self, forKey: "totalAssetsCount")
        topFundAssets = try container.decodeIfPresent([FundAssetPercent].self, forKey: "topFundAssets")
        statistic = try container.decodeIfPresent(FundDetailsListStatistic.self, forKey: "statistic")
        personalDetails = try container.decodeIfPresent(PersonalFundDetailsFull.self, forKey: "personalDetails")
        id = try container.decodeIfPresent(UUID.self, forKey: "id")
        logo = try container.decodeIfPresent(String.self, forKey: "logo")
        url = try container.decodeIfPresent(String.self, forKey: "url")
        color = try container.decodeIfPresent(String.self, forKey: "color")
        title = try container.decodeIfPresent(String.self, forKey: "title")
        description = try container.decodeIfPresent(String.self, forKey: "description")
        status = try container.decodeIfPresent(Status.self, forKey: "status")
        manager = try container.decodeIfPresent(ProfilePublic.self, forKey: "manager")
        chart = try container.decodeIfPresent([ChartSimple].self, forKey: "chart")
        dashboardAssetsDetails = try container.decodeIfPresent(DashboardProgramDetails.self, forKey: "dashboardAssetsDetails")
    }
}

