//
//  TattooIdeaCell.swift
//  TattooApp_PetProject
//
//  Created by Поляндий on 16.10.2022.
//

import UIKit
import SDWebImage

class TattooIdeaCell: UICollectionViewCell {
    
    static let identifier = "TattooIdeaCell"
    @IBOutlet weak var photoView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var googlePhoto: Result! {
        didSet {
            let photoURL = googlePhoto?.thumbnail
            guard let imageURL = photoURL, let url = URL(string: imageURL) else {return}
            photoView.sd_setImage(with: url , completed: nil)
        }
    }
}
