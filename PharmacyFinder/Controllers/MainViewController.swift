//
//  ViewController.swift
//  PharmacyFinder
//
//  Created by Gökhan Uysal on 22.11.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var cityTableView: UITableView!
    private let pharmacyDataSource = PharmacyDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cities"
        pharmacyDataSource.pharmacyDelegate = self
        pharmacyDataSource.fetchCityData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let senderCell: CityTableViewCell = sender as? CityTableViewCell,
            let destination: RegionViewController = segue.destination as? RegionViewController
        {
            destination.cityId = senderCell.cityId
        }
    }
}

extension MainViewController: UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pharmacyDataSource.getCityCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell") as? CityTableViewCell
        else  {
            return UITableViewCell()
        }
        
        if
            let city = pharmacyDataSource.getCityWithId(for: indexPath.row)
        {
            cell.cityNameLabel.text = city.Name
            cell.cityId = city.Id
        }
        else{
            cell.cityNameLabel.text = "NAN"
        }
        return cell
    }
}
extension MainViewController: PharmacyDelegate{
    func cityDataLoaded() {
        self.cityTableView.reloadData()
    }
}
