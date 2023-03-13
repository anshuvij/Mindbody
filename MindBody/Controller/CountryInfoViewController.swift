//
//  CountryInfoViewController.swift
//  MindBody
//
//  Created by Anshu Vij on 12/03/23.
//

import UIKit

class CountryInfoViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    
    var countryModels : CountryInfo?
    
    var countryInfoVM = CountryInfoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getCountryDataValues()
    }
    
    func setupUI() {
        
        countryInfoVM.delegate = self
        tableView.register(UINib(nibName: Constants.countryViewCell, bundle: nil), forCellReuseIdentifier: Constants.countryViewCell)
        tableView.delegate = self
        tableView.dataSource = self
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(getCountryData), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Country Data ...")
    
    }
    
    @objc func getCountryData() {
        self.refreshControl.beginRefreshing()
        getCountryDataValues()
    }
    
    func getCountryDataValues() {
        
        DelayIndicator.shared.showProgressView(uiView: view)
        countryInfoVM.fetchCountryInfo()
    }


}

extension CountryInfoViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return countryModels?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.countryViewCell, for: indexPath) as? CountryViewCell else { return UITableViewCell() }
        
        if let countryModels = countryModels {
            cell.configure(countryData: countryModels[indexPath.section])
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
      
        
        if let countryModels = countryModels {
            
            let vm = CountryDetailsViewController()
            vm.countryId = countryModels[indexPath.section].id
            vm.countryName = countryModels[indexPath.section].name
            self.navigationController?.pushViewController(vm, animated: true)
            
            
        }
        
    }
    
    
    
}

extension CountryInfoViewController : CountryInfoProtocol {
    
    func didFailWithError(error: Error) {
        
        DispatchQueue.main.async { [weak self] in
            DelayIndicator.shared.hideProgressView()
            self?.refreshControl.endRefreshing()
            let alertController = UIAlertController(title: "Something went wrong", message: "Please Check Internet Connectivity", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Retry", style: .default) { (UIAlertAction) in
                self?.getCountryDataValues()
            }
            alertController.addAction(OKAction)
            
            self?.present(alertController, animated: true, completion: nil)
        }
        
    }
    
   
    
    func countryInfo(_ vm: CountryInfoViewModel, data: CountryInfo) {
        
        DispatchQueue.main.async { [weak self] in
            DelayIndicator.shared.hideProgressView()
            self?.refreshControl.endRefreshing()
            self?.countryModels = data
            self?.tableView.reloadData()
        }
    }
    
  
    
}

