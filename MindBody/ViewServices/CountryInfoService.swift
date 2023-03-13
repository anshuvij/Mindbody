//
//  CountryInfoService.swift
//  MindBody
//
//  Created by Anshu Vij on 12/03/23.
//

import Foundation

protocol CountryInfoDelegate {
    
    func getCountryInfo(completion: @escaping(Result<CountryInfo, NetworkError>) -> Void)
}

class CountryInfoService: CountryInfoDelegate  {
    
    func getCountryInfo(completion: @escaping(Result<CountryInfo, NetworkError>) -> Void) {
        
        guard let url = URL(string: Constants.base_url) else {
            return completion(.failure(.BadURL))
        }
      
        NetworkManager().fetchRequest(type: CountryInfo.self, url: url, completion: completion)
        
    }
}
    
