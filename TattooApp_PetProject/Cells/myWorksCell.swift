//
//  myWorksCell.swift
//  TattooApp_PetProject
//
//  Created by Поляндий on 12.10.2022.
//

import UIKit

class myWorksCell: UICollectionViewCell {
    
    private let photo: UIImageView = {
        let photo = UIImageView()
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.contentMode = .scaleAspectFill
        photo.clipsToBounds = true
        photo.layer.cornerRadius = 10
        return photo
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(photo)
        photo.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        photo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    }
    
    var data: MyCustomData? {
        didSet{
            guard let data = data else {return}
            photo.image = data.image
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
