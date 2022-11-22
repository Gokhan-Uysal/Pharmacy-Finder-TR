//
//  RegionViewController.swift
//  PharmacyFinder
//
//  Created by Gökhan Uysal on 22.11.2022.
//

import UIKit

class RegionViewController: UIViewController {
    
    var cityId: Int?
    let pharmacyDataSource = PharmacyDataSource()
    @IBOutlet weak var regionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Regions"
        if let cityId = self.cityId
        {
            pharmacyDataSource.fetchRegionWithId(id: cityId)
        }
        pharmacyDataSource.pharmacyDelegate = self
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let senderCell: RegionTableViewCell = sender as? RegionTableViewCell,
            let destination: PharmacyViewController = segue.destination as? PharmacyViewController
        {
            destination.pharmacyId = senderCell.regionId
        }
    }
    
}
extension RegionViewController: UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pharmacyDataSource.getRegionCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "regionCell") as? RegionTableViewCell
        else  {
            return UITableViewCell()
        }
        
        if
            let region = pharmacyDataSource.getRegionWithId(for: indexPath.row)
        {
            cell.regionNameLabel.text = region.Name
            cell.regionId = region.Id
        }
        else{
            cell.regionNameLabel.text = "NAN"
        }
        return cell
    }
}

extension RegionViewController: PharmacyDelegate{
    func regionDataLoaded() {
        self.regionTableView.reloadData()
    }
}
