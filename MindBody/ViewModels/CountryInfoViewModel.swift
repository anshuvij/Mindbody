//
//  CountryInfoViewModel.swift
//  MindBody
//
//  Created by Anshu Vij on 12/03/23.
//

import Foundation


protocol CountryInfoProtocol {
    
    func countryInfo(_ vm : CountryInfoViewModel, data : CountryInfo)
    func didFailWithError(error : Error)
}

class CountryInfoViewModel {
    
    let serviceHandler: CountryInfoDelegate
    var delegate : CountryInfoProtocol?
    
    init(serviceHandler: CountryInfoService = CountryInfoService()) {
        self.serviceHandler = serviceHandler
    }

    
    func fetchCountryInfo() {
        
        serviceHandler.getCountryInfo { result in
            switch result {
            case.success(let countryInfo) :
                self.delegate?.countryInfo(self, data: countryInfo)
                
            case .failure(let error) :
                self.delegate?.didFailWithError(error: error)
            }
        }
    }
}


