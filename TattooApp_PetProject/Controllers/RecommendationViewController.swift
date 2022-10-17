//
//  MoviesViewController.swift
//  TattooApp_PetProject
//
//  Created by Поляндий on 12.10.2022.
//

import Foundation
import UIKit

class RecommendationViewController: UIViewController {
    
    let cellSpacingHeight: CGFloat = 10
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var segmentControll: UISegmentedControl!
    @IBAction func changeSegment(_ sender: Any) {
        tableView.reloadData()
    }
    
    var beforeSessionDict: [String: String] = [
        "1": "За сутки запрещено употреблять алкоголь",
        "2": "Отложите сеанс, если заболели",
        "3": "Не принимайте лекарства, разжижающие кровь",
        "4": "Не приходите на сеанс голодным!",
        "5": "Не утомляйтесь, нужно выспаться"
    ]
        
    var afterSessionDict: [String: String] = [
        "1": "Заживляющую пленку необходимо носить 3-5 дней",
        "2": "После снятия пленки смазывайте татуировку в течение 10 дней вазелином/кокосовым маслом",
        "3": "Запрещено смазывать татуировку заживляющими мазями",
        "4": "Нельзя чесать татуировку в течение двух недель",
        "5": "БУдьте аккуратны с каросточкой на татуировке, она должна отходить естественным способом(не сдирайте ее самостоятельно!",
        "6": "Запрещено заниматься спортом в течение двух недель",
        "7": "Отложите походы в баню/сауну/бассейн/солярий на две недели"
    ]
    
    var contraindicationsDict: [String: String] = [
        "1": "Болезни плохой свертываемости крови (тромбоцитопения, фибринопения, гемофилия)",
        "2": "Тяжелые вирусные заболевания (гепатит, ВИЧ, СПИД)",
        "3": "Онкологические и острые воспалительные заболевания",
        "4": "Нарушение иммунитета",
        "5": "Психические расстройства и эпилепсия",
        "6": "Сахарный диабет 1 типа (инсулинозависимый) или тяжелое течение диабета 2 типа",
        "7": "Заболевания, связанные со значительным снижением иммунитета",
        "8": "Склонность к резким нарушениям артериального давления, в частности к гипертонии",
        "9": "Воспалительные и аллергические заболевания кожи",
        "10": "Простудные заболевания и повышенная температура",
        "11": "Для женщин – период беременности, кормления грудью и во время менструации",
        "12": "Алкогольное и наркотическое опьянение"
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .white
        sideMenuBtn.target = self.revealViewController()
        sideMenuBtn.action = #selector(self.revealViewController()?.revealSideMenu)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = #colorLiteral(red: 0.737254902, green: 0.1294117647, blue: 0.2941176471, alpha: 1)
        
        tableView.register(UINib(nibName: AfterSessionCell.identifier, bundle: nil), forCellReuseIdentifier: AfterSessionCell.identifier)
        tableView.register(UINib(nibName: BeforeSessionCell.identifier, bundle: nil), forCellReuseIdentifier: BeforeSessionCell.identifier)
        tableView.register(UINib(nibName: ContraindicationCell.identifier, bundle: nil), forCellReuseIdentifier: ContraindicationCell.identifier)
    }
    
    func loadCellAfter(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AfterSessionCell.identifier, for: indexPath) as! AfterSessionCell
        cell.numberLabel?.text = Array(afterSessionDict.keys.sorted())[indexPath.row]
        cell.descriptionLabel?.text = Array(afterSessionDict.values)[indexPath.row]
        return cell
    }
    
    func loadCellBefore(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BeforeSessionCell.identifier, for: indexPath) as! BeforeSessionCell
        cell.numberLabel?.text = Array(beforeSessionDict.keys.sorted())[indexPath.row]
        cell.descriptionLabel?.text = Array(beforeSessionDict.values)[indexPath.row]
        return cell
    }
    
    func loadCellContraindicationCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContraindicationCell.identifier, for: indexPath) as! ContraindicationCell
        cell.numberLabel?.text = Array(contraindicationsDict.keys.sorted())[indexPath.row]
        cell.descriptionLabel?.text = Array(contraindicationsDict.values)[indexPath.row]
        return cell
    }
}

extension RecommendationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentControll.selectedSegmentIndex {
        case 0:
            return beforeSessionDict.count
        case 1 :
            return afterSessionDict.count
        case 2:
            return contraindicationsDict.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch segmentControll.selectedSegmentIndex {
        case 0:
            return loadCellBefore(indexPath: indexPath)
        case 1 :
            return loadCellAfter(indexPath: indexPath)
        case 2:
            return loadCellContraindicationCell(indexPath: indexPath)
        default:
            return UITableViewCell()
        }
    }
}
