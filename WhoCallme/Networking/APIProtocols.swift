//
//  APIProtocols.swift
//  WhoCallme
//
//  Created by Muhammad Imran on 15/05/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation


// MARK: - PhoneNumber
struct PhoneNumber: Codable {
    var countryCode: Int?
    var countryCodeISO, location: String?
    var locationLatitude, locationLongitude: Double?
    var nationalNumber: Int?
    var numberOfLeadingZeros: String?
    var numberType: String?
    var isValidNumber: Bool?
    var carrier, phoneNumberE164: String?

    enum CodingKeys: String, CodingKey {
        case countryCode
        case countryCodeISO
        case location
        case locationLatitude
        case locationLongitude
        case nationalNumber
        case numberOfLeadingZeros
        case numberType
        case isValidNumber
        case carrier
        case phoneNumberE164
    }
}

struct CallingCodes: Codable {
    var apiMessage, countryCallingCode, isoCode2, isoCode: String?

    enum CodingKeys: String, CodingKey {
        case apiMessage
        case countryCallingCode
        case isoCode2
        case isoCode
    }
}
