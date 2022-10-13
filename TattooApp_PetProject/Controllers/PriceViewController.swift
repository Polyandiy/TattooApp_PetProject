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
        "Скидка имениннеку 20%":"Скидка действительна 3 дня до дня рождения и 3 дня после, при предъявлении оригинала документа, удостоверяющего личность. Скидка не распространяется на другие акции.",
        "Две и более мини-тату со скидкой 30%": "Скидка предоставляется при оформлении записи на 2 и более мини-тату за один сейчас.",
        "Скидка для подружек": "Приведи подругу и получу скидку на следующую татуировку/перманент/коррекцию 15%."
    ]
    
    var dictToDisplay: [String : String] = [:]
    var nibToUse = UITableViewCell.self
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func segmentClick(_ sender: Any) {
        switch segmentedController.selectedSegmentIndex {
        case 0:
            dictToDisplay = priceDictionary; nibToUse = PriceCell.self
        case 1 :
            dictToDisplay = stockDictionary; nibToUse = StockCell.self
        default:
            break
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .white
        self.sideMenuBtn.target = revealViewController()
        self.sideMenuBtn.action = #selector(self.revealViewController()?.revealSideMenu)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(nibToUse, forCellReuseIdentifier: "identifier")
//        switch segmentedController.selectedSegmentIndex {
//        case 0:
//            tableView.register(PriceCell.self, forCellReuseIdentifier: "PriceCell")
//        case 1 :
//            tableView.register(StockCell.self, forCellReuseIdentifier: "StockCell")
//        default:
//            break
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.revealViewController()?.gestureEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.revealViewController()?.gestureEnabled = true
    }
}

extension PriceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath)
        
        //swith for table?
        
        return cell
    }
    
    
}
