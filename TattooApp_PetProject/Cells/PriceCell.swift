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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
        self.nameOfServiceLabel.textColor = .white
        self.priceLabel.textColor = .white
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}
