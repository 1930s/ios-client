//
// ProfileFullViewModel.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class ProfileFullViewModel: Codable {

    public var firstName: String?
    public var middleName: String?
    public var lastName: String?
    public var documentType: String?
    public var documentNumber: String?
    public var country: String?
    public var city: String?
    public var address: String?
    public var phone: String?
    public var birthday: Date?
    public var gender: Bool?
    public var avatar: String?
    public var email: String?
    public var balance: Double?


    
    public init(firstName: String?, middleName: String?, lastName: String?, documentType: String?, documentNumber: String?, country: String?, city: String?, address: String?, phone: String?, birthday: Date?, gender: Bool?, avatar: String?, email: String?, balance: Double?) {
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
        self.documentType = documentType
        self.documentNumber = documentNumber
        self.country = country
        self.city = city
        self.address = address
        self.phone = phone
        self.birthday = birthday
        self.gender = gender
        self.avatar = avatar
        self.email = email
        self.balance = balance
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(firstName, forKey: "firstName")
        try container.encodeIfPresent(middleName, forKey: "middleName")
        try container.encodeIfPresent(lastName, forKey: "lastName")
        try container.encodeIfPresent(documentType, forKey: "documentType")
        try container.encodeIfPresent(documentNumber, forKey: "documentNumber")
        try container.encodeIfPresent(country, forKey: "country")
        try container.encodeIfPresent(city, forKey: "city")
        try container.encodeIfPresent(address, forKey: "address")
        try container.encodeIfPresent(phone, forKey: "phone")
        try container.encodeIfPresent(birthday, forKey: "birthday")
        try container.encodeIfPresent(gender, forKey: "gender")
        try container.encodeIfPresent(avatar, forKey: "avatar")
        try container.encodeIfPresent(email, forKey: "email")
        try container.encodeIfPresent(balance, forKey: "balance")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        firstName = try container.decodeIfPresent(String.self, forKey: "firstName")
        middleName = try container.decodeIfPresent(String.self, forKey: "middleName")
        lastName = try container.decodeIfPresent(String.self, forKey: "lastName")
        documentType = try container.decodeIfPresent(String.self, forKey: "documentType")
        documentNumber = try container.decodeIfPresent(String.self, forKey: "documentNumber")
        country = try container.decodeIfPresent(String.self, forKey: "country")
        city = try container.decodeIfPresent(String.self, forKey: "city")
        address = try container.decodeIfPresent(String.self, forKey: "address")
        phone = try container.decodeIfPresent(String.self, forKey: "phone")
        birthday = try container.decodeIfPresent(Date.self, forKey: "birthday")
        gender = try container.decodeIfPresent(Bool.self, forKey: "gender")
        avatar = try container.decodeIfPresent(String.self, forKey: "avatar")
        email = try container.decodeIfPresent(String.self, forKey: "email")
        balance = try container.decodeIfPresent(Double.self, forKey: "balance")
    }
}

