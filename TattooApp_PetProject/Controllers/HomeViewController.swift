//
//  HomeViewController.swift
//  TattooApp_PetProject
//
//  Created by Поляндий on 12.10.2022.
//

import Foundation
import UIKit

struct MyCustomData{
    var image = UIImage()
}

class HomeViewController: UIViewController {
    
    private var data = [
        MyCustomData(image: Image.imege1),
        MyCustomData(image: Image.imege2),
        MyCustomData(image: Image.imege3),
        MyCustomData(image: Image.imege4),
        MyCustomData(image: Image.imege5),
        MyCustomData(image: Image.imege6),
        MyCustomData(image: Image.imege7),
        MyCustomData(image: Image.imege8),
        MyCustomData(image: Image.imege9),
        MyCustomData(image: Image.imege10),
        MyCustomData(image: Image.imege11),
        MyCustomData(image: Image.imege12),
        MyCustomData(image: Image.imege13),
        MyCustomData(image: Image.imege14),
        MyCustomData(image: Image.imege15),
        MyCustomData(image: Image.imege16),
        MyCustomData(image: Image.imege17),
        MyCustomData(image: Image.imege18)
    ]
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var myPhotoView: UIImageView!
    
    private var myWorksCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    let countCell = 3
    let offset: CGFloat = 2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Menu Button Tint Color
        navigationController?.navigationBar.tintColor = .white

        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        
        setupCollectionView()
        myWorksCollectionView.delegate = self
        myWorksCollectionView.dataSource = self
        myWorksCollectionView.register(myWorksCell.self, forCellWithReuseIdentifier: "myWorksCell")
    }
    
//    private func setupDescriptionLabel() {
//
//    }
    
    private func setupCollectionView() {
        view.addSubview(myWorksCollectionView)
        myWorksCollectionView.topAnchor.constraint(equalTo: myPhotoView.bottomAnchor, constant: 40).isActive = true
        myWorksCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        myWorksCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        myWorksCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myWorksCollectionView.dequeueReusableCell(withReuseIdentifier: "myWorksCell", for: indexPath) as! myWorksCell
        cell.data = data[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = myWorksCollectionView.frame.width/3 - 1
        return CGSize(width: width, height: width)
    }
}
