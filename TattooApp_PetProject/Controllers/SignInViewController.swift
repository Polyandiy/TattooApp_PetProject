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

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    
    @IBOutlet weak var forgottenPasswordLabel: UIButton!
    
    private var userEmail = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .white
        sideMenuBtn.target = self.revealViewController()
        sideMenuBtn.action = #selector(self.revealViewController()?.revealSideMenu)
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }

    
    @IBAction func switchLogin(_ sender: UIButton) {
        
        let email = loginTextField.text!
        let pass = passwordTextField.text!
        
        if (!email.isEmpty && !pass.isEmpty){
            Auth.auth().signIn(withEmail: email, password: pass) { [weak self] (result, error) in
                if error == nil {
                    let vc = SettingsViewController()
                    self?.navigationController?.pushViewController(vc, animated: true)
                } else {
                    self?.showSigninAlert()
                }
            }
        } else {
            showTextAlert()
        }
    }
    
    @IBAction func restorePassword(_ sender: UIButton) {
        print("Восстановление пароля")
    }
    
    private func showTextAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func showSigninAlert() {
        let alert = UIAlertController(title: "Неправильно введен логин или пароль", message: "Пожалуйста, проверьте правильность введенных вами данных", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func showPasswordRecoveryAlert() {
        let alertSheet = UIAlertController(title: "Сброс пароля", message: "Пожалйста, введите ваш email", preferredStyle: .actionSheet)
        let continueButton = UIAlertAction(title: "Продолжить", style: .default) { (action) in
            let emailTF = alertSheet.textFields?.first
            guard let email = emailTF?.text else {return}
            Auth.auth().sendPasswordReset(withEmail: email) { [weak self] (error) in
                if error == nil {
                    return
                } else {
                    self?.invalidEmailAlert()
                }
            }
        }
        let cancelButton = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        
        alertSheet.addTextField { tf in
        }
        alertSheet.addAction(continueButton)
        alertSheet.addAction(cancelButton)
        present(alertSheet, animated: true, completion: nil)
    }
    
    private func invalidEmailAlert(){
        let alert = UIAlertController(title: "Ошибка", message: "Неверный email", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ок", style: .default, handler: nil)
        
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    
}
