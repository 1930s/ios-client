//
// ProgramDetailsFull.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class ProgramDetailsFull: Codable {

    public enum Currency: String, Codable { 
        case undefined = "Undefined"
        case gvt = "GVT"
        case eth = "ETH"
        case btc = "BTC"
        case ada = "ADA"
        case usdt = "USDT"
        case xrp = "XRP"
        case bch = "BCH"
        case ltc = "LTC"
        case doge = "DOGE"
        case bnb = "BNB"
        case usd = "USD"
        case eur = "EUR"
    }
    public enum Status: String, Codable { 
        case _none = "None"
        case pending = "Pending"
        case errorCreating = "ErrorCreating"
        case active = "Active"
        case closed = "Closed"
        case archived = "Archived"
        case closedDueToInactivity = "ClosedDueToInactivity"
    }
    public var currency: Currency?
    public var level: Int?
    public var periodDuration: Int?
    public var periodStarts: Date?
    public var periodEnds: Date?
    public var entryFee: Double?
    public var entryFeeSelected: Double?
    public var entryFeeCurrent: Double?
    public var successFee: Double?
    public var isReinvesting: Bool?
    public var availableInvestment: Double?
    public var statistic: ProgramStatistic?
    public var rating: ProgramDetailsRating?
    /** Fields for authorized user */
    public var personalProgramDetails: PersonalProgramDetailsFull?
    public var tags: [ProgramTag]?
    public var id: UUID?
    public var logo: String?
    public var url: String?
    public var color: String?
    public var description: String?
    public var title: String?
    public var ipfsHash: String?
    public var status: Status?
    public var manager: ProfilePublic?


    
    public init(currency: Currency?, level: Int?, periodDuration: Int?, periodStarts: Date?, periodEnds: Date?, entryFee: Double?, entryFeeSelected: Double?, entryFeeCurrent: Double?, successFee: Double?, isReinvesting: Bool?, availableInvestment: Double?, statistic: ProgramStatistic?, rating: ProgramDetailsRating?, personalProgramDetails: PersonalProgramDetailsFull?, tags: [ProgramTag]?, id: UUID?, logo: String?, url: String?, color: String?, description: String?, title: String?, ipfsHash: String?, status: Status?, manager: ProfilePublic?) {
        self.currency = currency
        self.level = level
        self.periodDuration = periodDuration
        self.periodStarts = periodStarts
        self.periodEnds = periodEnds
        self.entryFee = entryFee
        self.entryFeeSelected = entryFeeSelected
        self.entryFeeCurrent = entryFeeCurrent
        self.successFee = successFee
        self.isReinvesting = isReinvesting
        self.availableInvestment = availableInvestment
        self.statistic = statistic
        self.rating = rating
        self.personalProgramDetails = personalProgramDetails
        self.tags = tags
        self.id = id
        self.logo = logo
        self.url = url
        self.color = color
        self.description = description
        self.title = title
        self.ipfsHash = ipfsHash
        self.status = status
        self.manager = manager
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(currency, forKey: "currency")
        try container.encodeIfPresent(level, forKey: "level")
        try container.encodeIfPresent(periodDuration, forKey: "periodDuration")
        try container.encodeIfPresent(periodStarts, forKey: "periodStarts")
        try container.encodeIfPresent(periodEnds, forKey: "periodEnds")
        try container.encodeIfPresent(entryFee, forKey: "entryFee")
        try container.encodeIfPresent(entryFeeSelected, forKey: "entryFeeSelected")
        try container.encodeIfPresent(entryFeeCurrent, forKey: "entryFeeCurrent")
        try container.encodeIfPresent(successFee, forKey: "successFee")
        try container.encodeIfPresent(isReinvesting, forKey: "isReinvesting")
        try container.encodeIfPresent(availableInvestment, forKey: "availableInvestment")
        try container.encodeIfPresent(statistic, forKey: "statistic")
        try container.encodeIfPresent(rating, forKey: "rating")
        try container.encodeIfPresent(personalProgramDetails, forKey: "personalProgramDetails")
        try container.encodeIfPresent(tags, forKey: "tags")
        try container.encodeIfPresent(id, forKey: "id")
        try container.encodeIfPresent(logo, forKey: "logo")
        try container.encodeIfPresent(url, forKey: "url")
        try container.encodeIfPresent(color, forKey: "color")
        try container.encodeIfPresent(description, forKey: "description")
        try container.encodeIfPresent(title, forKey: "title")
        try container.encodeIfPresent(ipfsHash, forKey: "ipfsHash")
        try container.encodeIfPresent(status, forKey: "status")
        try container.encodeIfPresent(manager, forKey: "manager")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        currency = try container.decodeIfPresent(Currency.self, forKey: "currency")
        level = try container.decodeIfPresent(Int.self, forKey: "level")
        periodDuration = try container.decodeIfPresent(Int.self, forKey: "periodDuration")
        periodStarts = try container.decodeIfPresent(Date.self, forKey: "periodStarts")
        periodEnds = try container.decodeIfPresent(Date.self, forKey: "periodEnds")
        entryFee = try container.decodeIfPresent(Double.self, forKey: "entryFee")
        entryFeeSelected = try container.decodeIfPresent(Double.self, forKey: "entryFeeSelected")
        entryFeeCurrent = try container.decodeIfPresent(Double.self, forKey: "entryFeeCurrent")
        successFee = try container.decodeIfPresent(Double.self, forKey: "successFee")
        isReinvesting = try container.decodeIfPresent(Bool.self, forKey: "isReinvesting")
        availableInvestment = try container.decodeIfPresent(Double.self, forKey: "availableInvestment")
        statistic = try container.decodeIfPresent(ProgramStatistic.self, forKey: "statistic")
        rating = try container.decodeIfPresent(ProgramDetailsRating.self, forKey: "rating")
        personalProgramDetails = try container.decodeIfPresent(PersonalProgramDetailsFull.self, forKey: "personalProgramDetails")
        tags = try container.decodeIfPresent([ProgramTag].self, forKey: "tags")
        id = try container.decodeIfPresent(UUID.self, forKey: "id")
        logo = try container.decodeIfPresent(String.self, forKey: "logo")
        url = try container.decodeIfPresent(String.self, forKey: "url")
        color = try container.decodeIfPresent(String.self, forKey: "color")
        description = try container.decodeIfPresent(String.self, forKey: "description")
        title = try container.decodeIfPresent(String.self, forKey: "title")
        ipfsHash = try container.decodeIfPresent(String.self, forKey: "ipfsHash")
        status = try container.decodeIfPresent(Status.self, forKey: "status")
        manager = try container.decodeIfPresent(ProfilePublic.self, forKey: "manager")
    }
}

