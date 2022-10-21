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
        photo.contentMode = .scaleAspectFit
        photo.clipsToBounds = true
        photo.layer.cornerRadius = 10
        return photo
    }()
    
    private let checkmark: UIImageView = {
        let image = UIImage(systemName: "suit.heart.fill")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPhotoView()
        setupCheckmarkView()
        updateSelectedState()
    }
    
    override var isSelected: Bool {
        didSet {
            updateSelectedState()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoView.image = nil
    }
    
    private func updateSelectedState() {
        photoView.alpha = isSelected ? 0.7 : 1
        checkmark.alpha = isSelected ? 1 : 0
    }
    
    private func setupPhotoView() {
        contentView.addSubview(photoView)
        photoView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        photoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        photoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        photoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    }
    
    private func setupCheckmarkView() {
        addSubview(checkmark)
        checkmark.trailingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: -8).isActive = true
        checkmark.bottomAnchor.constraint(equalTo: photoView.bottomAnchor, constant: -8).isActive = true
    }
    
    var googlePhoto: Result! {
        didSet {
//            let photoURL = googlePhoto?.thumbnail
//            guard let imageURL = photoURL, let url = URL(string: imageURL) else {return}
//            photoView.sd_setImage(with: url, completed: nil)
            DispatchQueue.global().async{ [weak self] in
            guard let imageURL = URL(string: self?.googlePhoto.thumbnail ?? "") else {return}
            guard let data = try? Data(contentsOf: imageURL) else {return}
                DispatchQueue.main.async {
                    self?.photoView.image = UIImage(data: data)
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
