//
//  CountryViewCell.swift
//  MindBody
//
//  Created by Anshu Vij on 12/03/23.
//

import UIKit

class CountryViewCell: UITableViewCell {

    @IBOutlet weak var countryFlag: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(countryData : CountryInfoResponse)
    {
        self.countryName.text = countryData.name.capitalized
        self.countryFlag.image = UIImage(named: countryData.code.lowercased())
    }
    
    func configureProvince(provinceData : ProvinceInfoResponse)
    {
        self.countryName.text = provinceData.name.capitalized
        self.countryFlag.image = UIImage(named: provinceData.countryCode.lowercased())
    }
    
}
