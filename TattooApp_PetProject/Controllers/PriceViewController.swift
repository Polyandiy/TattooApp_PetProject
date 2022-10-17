//
//  MusicViewController.swift
//  TattooApp_PetProject
//
//  Created by Поляндий on 12.10.2022.
//

import Foundation
import UIKit

class PriceViewController: UIViewController {
    
    var priceDictionary: [String : String] = [
        "мини-тату": "2000-4000р",
        "перманент бровей" : "4500р",
        "коррекция" : "50% от тату",
        "коррекция пм бровей" : "2500"
    ]

    var stockDictionary: [String : String] = [
        "Скидка имениннику 20%":"Скидка действительна 3 дня до дня рождения и 3 дня после, при предъявлении оригинала документа, удостоверяющего личность. Скидка не распространяется на другие акции.",
        "Две и более мини-тату со скидкой 30%": "Скидка предоставляется при оформлении записи на 2 и более мини-тату за один сейчас.",
        "Скидка для подружек": "Приведи подругу и получу скидку на следующую татуировку/перманент/коррекцию 15%."
    ]
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func segmentClick(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .white
        self.sideMenuBtn.target = revealViewController()
        self.sideMenuBtn.action = #selector(self.revealViewController()?.revealSideMenu)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.737254902, green: 0.1294117647, blue: 0.2941176471, alpha: 1)
        
        tableView.register(UINib(nibName: PriceCell.identifier, bundle: nil), forCellReuseIdentifier: PriceCell.identifier)
        tableView.register(UINib(nibName: StockCell.identifier, bundle: nil), forCellReuseIdentifier: StockCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.revealViewController()?.gestureEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.revealViewController()?.gestureEnabled = true
    }
    

    func loadCellPrice(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PriceCell.identifier, for: indexPath) as! PriceCell
        cell.nameOfServiceLabel?.text = Array(priceDictionary.keys)[indexPath.row]
        cell.priceLabel?.text = Array(priceDictionary.values)[indexPath.row]
        return cell
    }
    
    func loadCellStock(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.identifier, for: indexPath) as! StockCell
        cell.nameStock?.text = Array(stockDictionary.keys)[indexPath.row]
        cell.descriptionStock?.text = Array(stockDictionary.values)[indexPath.row]
        return cell
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension PriceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedController.selectedSegmentIndex {
        case 0:
            return priceDictionary.count
        case 1 :
            return stockDictionary.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch segmentedController.selectedSegmentIndex {
        case 0:
            return loadCellPrice(indexPath: indexPath)
        case 1 :
            return loadCellStock(indexPath: indexPath)
        default:
            return UITableViewCell()
        }
    }
}
