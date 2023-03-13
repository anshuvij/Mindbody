//
//  CountryDetailsViewController.swift
//  MindBody
//
//  Created by Anshu Vij on 12/03/23.
//

import UIKit
import MapKit
import CoreLocation

class CountryDetailsViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var noProvinceText: UILabel!
    private var provinceModel : ProvinceInfo?
    
    let provinceInfo = ProvinceInfoViewModel()
    var countryName : String = ""
    lazy var geocoder = CLGeocoder()
  
    
    
    var countryId : Int? {
        didSet {
           
            DelayIndicator.shared.showProgressView(uiView: view)
            if let countryId = countryId
            {
                provinceInfo.fetchProvinceInfo(countryId: countryId)
            }

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        
        provinceInfo.delegate = self
        tableView.register(UINib(nibName: Constants.countryViewCell, bundle: nil), forCellReuseIdentifier: Constants.countryViewCell)
        tableView.delegate = self
        tableView.dataSource = self
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showCountryLocation(name : countryName)
    }
    
    func showCountryLocation(name : String) {
        
       
        geocoder.geocodeAddressString(name) { (placemarks, error) in
            // Process Response
            self.processResponse(withPlacemarks: placemarks, error: error)
        }
        
    }
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        // Update View
        
        if let error = error {
            print("Unable to Forward Geocode Address (\(error))")
            customAlert()
        } else {
            var location: CLLocation?
            
            if let placemarks = placemarks, placemarks.count > 0 {
                location = placemarks.first?.location
            }

            if let location = location {
                let coordinateRegion = MKCoordinateRegion(center: location.coordinate,span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0))
                mapView.setRegion(coordinateRegion, animated: true)
                
            } else {
                customAlert()
            }
        }
    }
    
    func customAlert() {
        let alertController = UIAlertController(title: "Something went wrong", message: "", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Retry", style: .default) { (UIAlertAction) in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}

extension CountryDetailsViewController : ProvinceInfoProtocol {
    func didFailWithError(error: Error) {
        
        DispatchQueue.main.async { [weak self] in
            DelayIndicator.shared.hideProgressView()
            self?.customAlert()
        }
        
    }
    
    func provinceInfo(_ vm: ProvinceInfoViewModel, data: ProvinceInfo) {
        
        DispatchQueue.main.async { [weak self] in
            DelayIndicator.shared.hideProgressView()
            
            if data.count > 0
            {
                self?.noProvinceText.isHidden = true
                self?.provinceModel = data
                self?.tableView.reloadData()
            }
            else {
                self?.tableView.isHidden = true
                self?.mapView.isHidden = true
                self?.noProvinceText.isHidden = false
            }
            
        }
    }
    
    
}

extension CountryDetailsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return provinceModel?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.countryViewCell, for: indexPath) as? CountryViewCell else { return UITableViewCell() }
        if let provinceModel = provinceModel {
            cell.configureProvince(provinceData: provinceModel[indexPath.section])
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        if let provinceModel = provinceModel {
            showCountryLocation(name: provinceModel[indexPath.section].name)
        }
        
    }
    

    
    
    
}
