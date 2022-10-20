//
//  ProfileViewController.swift
//  TattooApp_PetProject
//
//  Created by Поляндий on 12.10.2022.
//

import Foundation
import UIKit

class TattooIdeasViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    
    var networkDataFetcher = NetworkDataFether()
    var photos = [Result]()
    
    lazy var cacheDataSourse: NSCache<AnyObject, Result> = {
        let cache = NSCache<AnyObject, Result>()
        return cache
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .white
        sideMenuBtn.target = self.revealViewController()
        sideMenuBtn.action = #selector(self.revealViewController()?.revealSideMenu)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TattooIdeaCell.self, forCellWithReuseIdentifier: "TattooIdeaCell")
        
        loadImage()
    }
    
    private func loadImage() {
        self.networkDataFetcher.fetchImages { [weak self] (results) in
            guard let fetchPhotos = results else {return}
            self?.photos = fetchPhotos.images_results
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension TattooIdeasViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TattooIdeaCell", for: indexPath) as! TattooIdeaCell
        
        if let image = cacheDataSourse.object(forKey: indexPath.item as AnyObject) {
            cell.googlePhoto = image
        } else {
            let googlePhoto = photos[indexPath.item]
            cell.googlePhoto = googlePhoto
            //            collectionView.reloadItems(at: [indexPath])
            self.cacheDataSourse.setObject(googlePhoto, forKey: indexPath.item as AnyObject)
        }
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension TattooIdeasViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width/3 - 5, height: view.frame.height/4 - 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
