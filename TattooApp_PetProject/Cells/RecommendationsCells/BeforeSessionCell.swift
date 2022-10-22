//
//  BeforeSessionCell.swift
//  TattooApp_PetProject
//
//  Created by Поляндий on 17.10.2022.
//

import UIKit

class BeforeSessionCell: UITableViewCell {

    static let identifier = "BeforeSessionCell"
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
        self.numberLabel.textColor = .white
        self.descriptionLabel.textColor = .white
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//    
}
