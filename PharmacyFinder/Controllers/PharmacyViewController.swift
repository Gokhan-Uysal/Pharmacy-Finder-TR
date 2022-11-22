//
//  PharmacyViewController.swift
//  PharmacyFinder
//
//  Created by Gökhan Uysal on 22.11.2022.
//

import UIKit

class PharmacyViewController: UIViewController {

    @IBOutlet weak var pharmacyTableView: UITableView!
    let pharmacyDataSource = PharmacyDataSource()
    var pharmacyId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pharmacies"
        if let pharmacyId = pharmacyId{
            pharmacyDataSource.fetchPharmaciesWithId(id: pharmacyId)
        }
        pharmacyDataSource.pharmacyDelegate = self
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let senderCell: PharmacyTableViewCell = sender as? PharmacyTableViewCell,
            let destinaton: PharmacyDetailViewController = segue.destination as? PharmacyDetailViewController
        {
            destinaton.pharmacyId = senderCell.pharmacyId
        }
        
    }
    
}

extension PharmacyViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pharmacyDataSource.getPharmacyCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pharmacyCell") as? PharmacyTableViewCell
        else  {
            return UITableViewCell()
        }
        
        if
            let region = pharmacyDataSource.getPharmacyWithId(for: indexPath.row)
        {
            cell.pharmacyNameLabel.text = region.Name
            cell.pharmacyId = region.Id
        }
        else{
            cell.pharmacyNameLabel.text = "NAN"
        }
        return cell
    }
}

extension PharmacyViewController: PharmacyDelegate{
    func pharmacyDataLoaded() {
        pharmacyTableView.reloadData()
    }
}
