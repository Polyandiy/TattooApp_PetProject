//
//  ContraindicationCell.swift
//  TattooApp_PetProject
//
//  Created by Поляндий on 17.10.2022.
//

import UIKit

class ContraindicationCell: UITableViewCell {

    static let identifier = "ContraindicationCell"
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
        self.numberLabel.textColor = .white
        self.descriptionLabel.textColor = .white
    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//    
}
