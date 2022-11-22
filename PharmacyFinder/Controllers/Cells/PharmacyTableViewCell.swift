//
//  PharmacyTableViewCell.swift
//  PharmacyFinder
//
//  Created by Gökhan Uysal on 22.11.2022.
//

import UIKit

class PharmacyTableViewCell: UITableViewCell {

    @IBOutlet weak var pharmacyNameLabel: UILabel!
    var pharmacyId: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
