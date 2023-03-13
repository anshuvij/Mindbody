//
//  ProvinceInfoService.swift
//  MindBody
//
//  Created by Anshu Vij on 12/03/23.
//

import Foundation
protocol ProvinceInfoDelegate {
    
    func getProvinceInfo(countryId : Int,completion: @escaping(Result<ProvinceInfo, NetworkError>) -> Void)
}

class ProvinceInfoService: ProvinceInfoDelegate  {
    
    func getProvinceInfo(countryId : Int, completion: @escaping(Result<ProvinceInfo, NetworkError>) -> Void) {
        
        guard let url = URL(string: Constants.base_url+"/\(countryId)" + "/province") else {
            return completion(.failure(.BadURL))
        }
      
        NetworkManager().fetchRequest(type: ProvinceInfo.self, url: url, completion: completion)
        
    }
}
