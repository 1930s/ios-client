//
// ProfileHeaderViewModel.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class ProfileHeaderViewModel: Codable {

    public var id: UUID?
    public var name: String?
    public var email: String?
    public var avatar: String?
    public var notificationsCount: Int?
    public var favoritesCount: Int?
    public var totalBalanceGvt: Double?
    public var investedGvt: Double?
    public var availableGvt: Double?
    public var kycConfirmed: Bool?


    
    public init(id: UUID?, name: String?, email: String?, avatar: String?, notificationsCount: Int?, favoritesCount: Int?, totalBalanceGvt: Double?, investedGvt: Double?, availableGvt: Double?, kycConfirmed: Bool?) {
        self.id = id
        self.name = name
        self.email = email
        self.avatar = avatar
        self.notificationsCount = notificationsCount
        self.favoritesCount = favoritesCount
        self.totalBalanceGvt = totalBalanceGvt
        self.investedGvt = investedGvt
        self.availableGvt = availableGvt
        self.kycConfirmed = kycConfirmed
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(id, forKey: "id")
        try container.encodeIfPresent(name, forKey: "name")
        try container.encodeIfPresent(email, forKey: "email")
        try container.encodeIfPresent(avatar, forKey: "avatar")
        try container.encodeIfPresent(notificationsCount, forKey: "notificationsCount")
        try container.encodeIfPresent(favoritesCount, forKey: "favoritesCount")
        try container.encodeIfPresent(totalBalanceGvt, forKey: "totalBalanceGvt")
        try container.encodeIfPresent(investedGvt, forKey: "investedGvt")
        try container.encodeIfPresent(availableGvt, forKey: "availableGvt")
        try container.encodeIfPresent(kycConfirmed, forKey: "kycConfirmed")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        id = try container.decodeIfPresent(UUID.self, forKey: "id")
        name = try container.decodeIfPresent(String.self, forKey: "name")
        email = try container.decodeIfPresent(String.self, forKey: "email")
        avatar = try container.decodeIfPresent(String.self, forKey: "avatar")
        notificationsCount = try container.decodeIfPresent(Int.self, forKey: "notificationsCount")
        favoritesCount = try container.decodeIfPresent(Int.self, forKey: "favoritesCount")
        totalBalanceGvt = try container.decodeIfPresent(Double.self, forKey: "totalBalanceGvt")
        investedGvt = try container.decodeIfPresent(Double.self, forKey: "investedGvt")
        availableGvt = try container.decodeIfPresent(Double.self, forKey: "availableGvt")
        kycConfirmed = try container.decodeIfPresent(Bool.self, forKey: "kycConfirmed")
    }
}

