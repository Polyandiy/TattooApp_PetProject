//
//  TattooIdeaCell.swift
//  TattooApp_PetProject
//
//  Created by Поляндий on 16.10.2022.
//

import UIKit
import SDWebImage

class TattooIdeaCell: UICollectionViewCell {
    
    let photoView: UIImageView = {
        let photo = UIImageView()
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.contentMode = .scaleAspectFill
        photo.clipsToBounds = true
        photo.layer.cornerRadius = 10
        return photo
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(photoView)
        photoView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        photoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        photoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        photoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var googlePhoto: Result! {
        didSet {
//            let photoURL = googlePhoto?.thumbnail
//            guard let imageURL = photoURL, let url = URL(string: imageURL) else {return}
//            photoView.sd_setImage(with: url, completed: nil)
            
            guard let imageURL = URL(string: googlePhoto.thumbnail) else {return}
            guard let data = try? Data(contentsOf: imageURL) else {return}
                self.photoView.image = UIImage(data: data)
        }
    }
}
