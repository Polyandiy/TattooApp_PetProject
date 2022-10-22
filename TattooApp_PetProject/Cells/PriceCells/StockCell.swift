//
//  StockCell.swift
//  TattooApp_PetProject
//
//  Created by Поляндий on 13.10.2022.
//

import UIKit

class StockCell: UITableViewCell {

    @IBOutlet weak var descriptionStock: UILabel!
    @IBOutlet weak var nameStock: UILabel!
    
    static let identifier = "StockCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
        self.descriptionStock.textColor = .white
        self.nameStock.textColor = .white
    }
    
}
