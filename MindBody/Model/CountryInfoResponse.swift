//
//  CountryInfoResponse.swift
//  MindBody
//
//  Created by Anshu Vij on 12/03/23.
//

import Foundation

struct CountryInfoResponse: Codable {
    let id: Int
    let name, code: String
    let phoneCode: String?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "Name"
        case code = "Code"
        case phoneCode = "PhoneCode"
    }
}

typealias CountryInfo = [CountryInfoResponse]
