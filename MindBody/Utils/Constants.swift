//
//  Constants.swift
//  MindBody
//
//  Created by Anshu Vij on 12/03/23.
//

import Foundation
struct Constants {
    struct Urls {
        
        static func urlForCountryProvince(id : Int) -> URL {
            return URL(string: "https://connect.mindbodyonline.com/rest/worldregions/country/\(id)/province")!
        }
        
        static func urlForCountryInfo() -> URL {
            return URL(string: "https://connect.mindbodyonline.com/rest/worldregions/country")!
        }
    }
    
    public static let base_url = "https://connect.mindbodyonline.com/rest/worldregions/country"
    
    public static let countryViewCell = "CountryViewCell"
}
