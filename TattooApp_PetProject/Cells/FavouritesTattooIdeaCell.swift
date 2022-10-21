//
//  FavouritesTattooIdeaCell.swift
//  TattooApp_PetProject
//
//  Created by Поляндий on 21.10.2022.
//

import UIKit

class FavouritesTattooIdeaCell: UICollectionViewCell {
    
    static let reuseId = "FavouritesTattooIdeaCell"
    
    var myImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .green
        return imageView
    }()
    
    var googlePhoto: Result! {
        didSet {
            DispatchQueue.global().async{ [weak self] in
            guard let imageURL = URL(string: self?.googlePhoto.thumbnail ?? "") else {return}
            guard let data = try? Data(contentsOf: imageURL) else {return}
                DispatchQueue.main.async {
                    self?.myImageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myImageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        backgroundColor = .green
        
        setupImageView()
    }
    
    func setupImageView() {
        addSubview(myImageView)
        myImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        myImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        myImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        myImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
