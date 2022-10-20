//
//  SettingsViewController.swift
//  TattooApp_PetProject
//
//  Created by Поляндий on 12.10.2022.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseAuth

class SettingsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    
    @IBOutlet weak var forgottenPasswordLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .white
        sideMenuBtn.target = self.revealViewController()
        sideMenuBtn.action = #selector(self.revealViewController()?.revealSideMenu)
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }

    
    @IBAction func switchLogin(_ sender: UIButton) {
    }
    
    @IBAction func restorePassword(_ sender: UIButton) {
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let email = loginTextField.text!
        let pass = passwordTextField.text!
        
        if (!email.isEmpty && !pass.isEmpty){
            Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
                if error == nil {
                    print("Выполнен вход")
                }
            }
        } else {
            showAlert()
        }
        
        return true
    }
}
