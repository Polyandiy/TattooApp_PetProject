//
//  BooksViewController.swift
//  TattooApp_PetProject
//
//  Created by Поляндий on 12.10.2022.
//

import Foundation
import UIKit

class RecordingViewController: UIViewController {
    
    var recordsStorage: RecordStorageProtocol = RecordStorage()
    
    public var records: [RecordProtocol] = [] {
        didSet {
            recordsStorage.saveRecord(records)
        }
    }

    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var recordLabel: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    private let enterLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.alpha = 0.8
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.text = """
Вы еще не записались на сеанс.

* Перед записью обязательно ознакомьтесь с рекомендациями и противопоказаниями.
"""
        return label
    }()
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RecordCell.self, forCellReuseIdentifier: "RecordCell")
        
        navigationController?.navigationBar.tintColor = .white
        sideMenuBtn.target = self.revealViewController()
        sideMenuBtn.action = #selector(self.revealViewController()?.revealSideMenu)
        
        loadRecords()
        setupTableView()
        setupEnterLabel()
    }
    
    @IBAction func recordingLabel(_ sender: UIBarButtonItem) {
        print("запись")
        let vc = DetailRecordViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - loadRecords
    
    private func loadRecords() {
        records = recordsStorage.loadRecord()
    }
    
    //MARK: - setup UI Elements
    
    private func setupEnterLabel() {
        view.addSubview(enterLabel)
        enterLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        enterLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        enterLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20).isActive = true
    }

    private func setupTableView() {
        if records.isEmpty {
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
            enterLabel.isHidden = true
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension RecordingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath) as! RecordCell
        let dateFormatter = DateFormatter()

        cell.timeLabel?.text = records[indexPath.row].time
        cell.dateLabel?.text = dateFormatter.string(from: records[indexPath.row].date)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Вы хотите отменить запись на сеанс?", message: "Отмена осуществляется не позднее чем за сутки до даты записи", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Да", style: .destructive) { _ in
            self.records.remove(at: indexPath.row)
            tableView.reloadData()
        }
        let cancel = UIAlertAction(title: "Нет", style: .default, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}
