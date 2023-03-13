//
//  ProvinceInfoResponse.swift
//  MindBody
//
//  Created by Anshu Vij on 12/03/23.
//

import Foundation

struct ProvinceInfoResponse: Codable {
    let id: Int
    let name, code, countryCode: String
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "Name"
        case code = "Code"
        case countryCode = "CountryCode"

    }
}

typealias ProvinceInfo = [ProvinceInfoResponse]
