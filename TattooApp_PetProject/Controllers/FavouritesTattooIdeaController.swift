//
//  FavouritesTattooIdeaController.swift
//  TattooApp_PetProject
//
//  Created by Поляндий on 21.10.2022.
//

import UIKit

private let reuseIdentifier = "Cell"

class FavouritesTattooIdeaController: UICollectionViewController {

    var photos = [Result]()
    
//    private lazy var removeBarButtonItem: UIBarButtonItem = {
//        let button = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeBarButtonTapped))
//        button.tintColor = .white
//        button.isEnabled = false
//        return button
//    }()
    
    private let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "You haven't add a photos yet"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(FavouritesTattooIdeaCell.self, forCellWithReuseIdentifier: FavouritesTattooIdeaCell.reuseId)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        setupEnterLabel()
    }
    
    //    @objc private func removeBarButtonTapped(){
    //
    //    }
    
    // MARK: - Setup UI Elements
    
    private func setupEnterLabel() {
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        enterSearchTermLabel.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 50).isActive = true
    }
    
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTermLabel.isHidden = photos.count != 0
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavouritesTattooIdeaCell.reuseId, for: indexPath) as! FavouritesTattooIdeaCell
        let googlePhoto = photos[indexPath.item]
        cell.googlePhoto = googlePhoto
        return cell
    }
}

    // MARK: - UICollectionViewDelegateFlowLayout
extension FavouritesTattooIdeaController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width/3 - 1, height: width/3 - 1)
    }
}
