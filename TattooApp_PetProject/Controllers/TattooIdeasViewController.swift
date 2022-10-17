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
    let countCells = 3
    let offset: CGFloat = 2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .white
        sideMenuBtn.target = self.revealViewController()
        sideMenuBtn.action = #selector(self.revealViewController()?.revealSideMenu)
        
        collectionView.register(TattooIdeaCell.self, forCellWithReuseIdentifier: "TattooIdeaCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        loadImage()
    }
    
    private func loadImage() {
        self.networkDataFetcher.fetchImages { [weak self] (results) in
            guard let fetchPhotos = results else {return}
            self?.photos = fetchPhotos.images_results
            self?.collectionView.reloadData()
        }
    }
    
}

extension TattooIdeasViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TattooIdeaCell", for: indexPath) as! TattooIdeaCell
        let googlePhoto = photos[indexPath.item]
        cell.googlePhoto = googlePhoto

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameVC = collectionView.frame
        let widthCell = frameVC.width / CGFloat(countCells)
        let heightCell = widthCell
        let spacing = CGFloat((countCells)) * offset / CGFloat(countCells)
        return CGSize(width: widthCell - spacing, height: heightCell - (offset * 2))
    }
}
