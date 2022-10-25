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
    private var selectedImages = [UIImage]()
    
    lazy var cacheDataSourse: NSCache<AnyObject, Result> = {
        let cache = NSCache<AnyObject, Result>()
        return cache
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = .gray
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private lazy var addBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonTapped))
        button.tintColor = .white
        button.isEnabled = false
        return button
    }()
    
    private lazy var favBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "heart.text.square"), style: .plain, target: self, action: #selector(showFavVC))
        button.tintColor = .white
        return button
    }()
    
    private lazy var selectBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "hand.tap.fill"), style: .plain, target: self, action: #selector(changeStateSelectButton))
        button.tintColor = .white
        return button
    }()
    
    private var numberOfSelectedPhotos: Int {
        return collectionView.indexPathsForSelectedItems?.count ?? 0
    }
    
//    override var isSelected: Bool {
//        didSet {
//
//        }
//    }
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .white
        sideMenuBtn.target = self.revealViewController()
        sideMenuBtn.action = #selector(self.revealViewController()?.revealSideMenu)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TattooIdeaCell.self, forCellWithReuseIdentifier: "TattooIdeaCell")
        
        navigationItem.rightBarButtonItems = [selectBarButton, addBarButtonItem, favBarButtonItem]
        
        setupSpinner()
        loadImage()
    }
    
    //MARK: - metods
    
    private func loadImage() {
        self.networkDataFetcher.fetchImages { [weak self] (results) in
            guard let fetchPhotos = results else {return}
            self?.photos = fetchPhotos.images_results
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    private func setupSpinner() {
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor).isActive = true
    }
    
    private func undateNavButtonsState() {
        addBarButtonItem.isEnabled = numberOfSelectedPhotos > 0
    }
    
    func refresh() {
        self.selectedImages.removeAll()
        self.collectionView.selectItem(at: nil, animated: true, scrollPosition: [])
        undateNavButtonsState()
    }
    
    @objc private func addBarButtonTapped(){
        let selectedPhotos = collectionView.indexPathsForSelectedItems?.reduce([], { (photosss, indexPath) -> [Result] in
            var mutablePhotos = photosss
            let photo = photos[indexPath.item]
            mutablePhotos.append(photo)
            return mutablePhotos
        })
        
        let alertController = UIAlertController(title: "", message: "\(selectedPhotos!.count) фото будут добавлены в альбом", preferredStyle: .alert)
        let add = UIAlertAction(title: "Добавить", style: .default) { (action) in
            
            let favVC = FavouritesTattooIdeaController(collectionViewLayout: UICollectionViewFlowLayout())
            favVC.photos.append(contentsOf: selectedPhotos!)
            favVC.collectionView.reloadData()
            print(favVC.photos.count)
            
            self.refresh()
        }
        let cancel = UIAlertAction(title: "Отменить", style: .cancel) { (action) in
        }
        alertController.addAction(add)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }
    
    @objc private func changeStateSelectButton() {
        
    }
    
    @objc private func showFavVC() {
        let favouriteVC = FavouritesTattooIdeaController(collectionViewLayout: UICollectionViewFlowLayout())
        self.navigationController?.pushViewController(favouriteVC, animated: true)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension TattooIdeasViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if photos.isEmpty {
            self.spinner.startAnimating()
        } else {
            self.spinner.stopAnimating()
            spinner.isHidden = true
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        undateNavButtonsState()
        let cell = collectionView.cellForItem(at: indexPath) as! TattooIdeaCell
        guard let image = cell.photoView.image else { return }
        selectedImages.append(image)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        undateNavButtonsState()
        let cell = collectionView.cellForItem(at: indexPath) as! TattooIdeaCell
        guard let image = cell.photoView.image else { return }
        if let index = selectedImages.firstIndex(of: image) {
            selectedImages.remove(at: index)
        }
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
