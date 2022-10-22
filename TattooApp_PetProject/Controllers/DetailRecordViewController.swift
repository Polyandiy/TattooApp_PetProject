//
//  DetailRecordViewController.swift
//  TattooApp_PetProject
//
//  Created by Поляндий on 22.10.2022.
//

import UIKit

class DetailRecordViewController: UIViewController {

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
        picker.backgroundColor = .white
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.layer.cornerRadius = 10
        return picker
    }()
    
    let timeSegment: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.backgroundColor = .white
//        segment.numberOfSegments =
//        segment.titleForSegment(at: 0) = "12:00"
//        segment.titleForSegment(at: 1) = "15:00"
//        segment.titleForSegment(at: 2) = "16:00"
//        segment.titleForSegment(at: 3) = "18:00"
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()
    
    lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveRecord))
        button.tintColor = .white
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = saveButton
        view.backgroundColor = .systemPink
        setupElements()
    }
    
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
    
    @objc private func saveRecord() {
        print("сохранено")
    }
    
}
