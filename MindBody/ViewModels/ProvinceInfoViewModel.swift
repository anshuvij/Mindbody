//
//  ProvinceInfoViewModel.swift
//  MindBody
//
//  Created by Anshu Vij on 12/03/23.
//

import Foundation


protocol ProvinceInfoProtocol {
    
    func provinceInfo(_ vm : ProvinceInfoViewModel, data : ProvinceInfo)
    func didFailWithError(error : Error)
}

class ProvinceInfoViewModel {
    
    let serviceHandler: ProvinceInfoDelegate
    var delegate : ProvinceInfoProtocol?
    
    init(serviceHandler: ProvinceInfoService = ProvinceInfoService()) {
        self.serviceHandler = serviceHandler
    }

    
    func fetchProvinceInfo(countryId : Int) {
        
        serviceHandler.getProvinceInfo(countryId: countryId) { result in
            switch result {
            case.success(let provinceInfo) :
                self.delegate?.provinceInfo(self, data: provinceInfo)
                
            case .failure(let error) :
                self.delegate?.didFailWithError(error: error)
            }
        }
    }
}

