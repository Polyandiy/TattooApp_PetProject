//
//  SettingsViewController.swift
//  TattooApp_PetProject
//
//  Created by Поляндий on 21.10.2022.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {
    
    lazy private var logOutBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Выйти", style: .plain, target: self, action: #selector(logOut))
        button.tintColor = .white
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        
        navigationItem.rightBarButtonItem = logOutBarButton
    }
    
    @objc func logOut(){
        do { try FirebaseAuth.Auth.auth().signOut()
            self.navigationController?.popViewController(animated: true)
        } catch {
            showSignoutAlert()
        }
    }
    
    private func showSignoutAlert() {
        let alert = UIAlertController(title: "Неизвестная ошибка", message: "Попробуйте еще раз", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}
