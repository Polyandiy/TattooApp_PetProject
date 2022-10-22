//
//  BooksViewController.swift
//  TattooApp_PetProject
//
//  Created by Поляндий on 12.10.2022.
//

import Foundation
import UIKit

class RecordingViewController: UIViewController {

    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var recordLabel: UIBarButtonItem!
    
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .white
        sideMenuBtn.target = self.revealViewController()
        sideMenuBtn.action = #selector(self.revealViewController()?.revealSideMenu)
        
        setupEnterLabel()
    }
    
    @IBAction func recordingLabel(_ sender: UIBarButtonItem) {
        print("запись")
        let vc = DetailRecordViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupEnterLabel() {
        view.addSubview(enterLabel)
        enterLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        enterLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        enterLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20).isActive = true
    }
    
}
