//
//  PharmacyDetailViewController.swift
//  PharmacyFinder
//
//  Created by Gökhan Uysal on 22.11.2022.
//

import UIKit

class PharmacyDetailViewController: UIViewController {

    @IBOutlet weak var pharmacyNameLabel: UILabel!
    
    @IBOutlet weak var pharmacyAddressLabel: UILabel!
    
    @IBOutlet weak var pharmacyPhoneNumberLabel: UILabel!
    
    let pharmacyDataSource = PharmacyDataSource()
    var pharmacyId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pharmacyId = self.pharmacyId
        {
            pharmacyDataSource.pharmacyDelegate = self
            pharmacyDataSource.fetchPharmacyWithId(id: pharmacyId)
            
        }
        // Do any additional setup after loading the view.
    }
}

extension PharmacyDetailViewController: PharmacyDelegate{
    func pharmacyDetailedDataLoaded(pharmacyData: PharmacyDetail) {
        pharmacyNameLabel.text = pharmacyData.Name
        pharmacyAddressLabel.text = pharmacyData.Address
        pharmacyPhoneNumberLabel.text = "0\(String(pharmacyData.Phone.trimmingCharacters(in: .whitespaces)))"
    }
}
