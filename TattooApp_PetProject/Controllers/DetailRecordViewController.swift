//
//  DetailRecordViewController.swift
//  TattooApp_PetProject
//
//  Created by Поляндий on 22.10.2022.
//

import UIKit

class DetailRecordViewController: UIViewController {
    
    var nameClient: String = ""
    var phoneClient: String = ""
    var time: String = ""
    var date = Date()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.placeholder = "Ваше имя"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 10
        return tf
    }()
    
    let phoneTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.placeholder = "Номер телефона"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 10
        return tf
    }()
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.backgroundColor = .white
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.layer.cornerRadius = 10
        return picker
    }()
    
    let timeSegment: UISegmentedControl = {
        let items = ["12:00", "14:00", "16:00", "18:00"]
        let segment = UISegmentedControl(items: items)
        segment.backgroundColor = .white
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.addTarget(self, action: #selector(selectValue), for: .valueChanged)
        return segment
    }()
    
    lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveRecord))
        button.tintColor = .white
        return button
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = saveButton
        view.backgroundColor = .systemPink
        
        nameTextField.text = nameClient
        phoneTextField.text = phoneClient
        datePicker.date = date.self
        
        setupElements()
    }
    
    //MARK: - setup UI Elements
    
    private func setupElements() {
        view.addSubview(nameTextField)
        nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(phoneTextField)
        phoneTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10).isActive = true
        phoneTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        phoneTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        phoneTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(datePicker)
        datePicker.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 10).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(timeSegment)
        timeSegment.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 10).isActive = true
        timeSegment.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        timeSegment.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        timeSegment.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func selectValue() {
        let index = timeSegment.selectedSegmentIndex
        switch index {
        case 0:
            return self.time = "12:00"
        case 1:
            return self.time = "14:00"
        case 2:
            return self.time = "16:00"
        case 3:
            return self.time = "18:00"
        default:
            break
        }
    }
    
    @objc private func saveRecord() {
        
        guard let nameTF = nameTextField.text, let phoneTF = phoneTextField.text else { return }
        self.nameClient = nameTF
        self.phoneClient = phoneTF
        date.self = datePicker.date
        
        if !nameTextField.hasText && !phoneTextField.hasText {
            let alert = UIAlertController(title: "Пожалйуста, заполните все поля", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "ОК", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true)
        }
        
        let record = RecordModel(nameClient: nameClient, numberPhone: phoneClient, date: date, time: time)
        let recVC = RecordingViewController()
        recVC.records.append(record)
        DispatchQueue.main.async {
            recVC.tableView.reloadData()
        }
        navigationController?.popViewController(animated: true)
    }
}
