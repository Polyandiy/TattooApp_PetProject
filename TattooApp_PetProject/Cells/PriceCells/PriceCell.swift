//
//  PriceCell.swift
//  TattooApp_PetProject
//
//  Created by Поляндий on 13.10.2022.
//

import UIKit

class PriceCell: UITableViewCell {

    @IBOutlet weak var nameOfServiceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    static let identifier = "PriceCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
        self.nameOfServiceLabel.textColor = .white
        self.priceLabel.textColor = .white
    }
    
}
