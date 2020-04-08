//
//  EditPerson.swift
//  Authentication
//
//  Created by David Sarkisyan on 06.04.2020.
//  Copyright © 2020 DavidS & that's all. All rights reserved.
//

import UIKit

class EditPersonViewController: UIViewController{
    
    let headerLabel = UILabel()
    
    let fullNameTextField = UITextField()
    
    let ages: [Int] = Array(0...100)
    let agePickerView = UIPickerView()
    
    let saveButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .black
        setupHeaderLabel()
        setupFullNameTextField()
        setupAgeTextField()
        setupSaveButton()
    }
    
    func setupHeaderLabel(){
        view.addSubview(headerLabel)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 30).isActive = true
        headerLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        headerLabel.font = UIFont(name: "HelveticaNeue", size: 35)
        headerLabel.text = "Edit Profile"
        headerLabel.textColor = .white
        headerLabel.textAlignment = .left
    }
    
    func setupFullNameTextField(){
        view.addSubview(fullNameTextField)
        
        fullNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        fullNameTextField.leftAnchor.constraint(equalTo: headerLabel.leftAnchor).isActive = true
        fullNameTextField.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 30).isActive = true
        fullNameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        fullNameTextField.heightAnchor.constraint(equalTo: headerLabel.heightAnchor).isActive = true
        
        fullNameTextField.attributedPlaceholder = configureAttributedPlaceholder(text: Person.shared.fullName)
        fullNameTextField.textAlignment = .left
        fullNameTextField.textColor = .white
        fullNameTextField.font = UIFont(name: "HelveticaNeue", size: 25)
        
        fullNameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        fullNameTextField.layer.borderWidth = 1
        fullNameTextField.layer.borderColor = UIColor.white.cgColor
        fullNameTextField.layer.cornerRadius = 20
    }
    
    func setupAgeTextField(){
        view.addSubview(agePickerView)
        
        agePickerView.translatesAutoresizingMaskIntoConstraints = false
        
        agePickerView.leftAnchor.constraint(equalTo: headerLabel.leftAnchor).isActive = true
        agePickerView.topAnchor.constraint(equalTo: fullNameTextField.bottomAnchor, constant: 30).isActive = true
        agePickerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        agePickerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        agePickerView.delegate = self
        agePickerView.dataSource = self
        
        agePickerView.selectRow(Person.shared.age ?? 0, inComponent: 0, animated: true)
        agePickerView.tintColor = .white
        
        agePickerView.subviews[1].backgroundColor = .white
        agePickerView.subviews[2].backgroundColor = .white
            
        agePickerView.layer.borderWidth = 1.5
        agePickerView.layer.borderColor = UIColor.white.cgColor
        agePickerView.layer.cornerRadius = 20
    }
    
    func configureAttributedPlaceholder(text: String?) -> NSAttributedString{
        let attrubutes: [NSAttributedString.Key : Any] = [ .foregroundColor: UIColor.white,
                                                           .backgroundColor: UIColor.clear ]
        let result = NSAttributedString(string: text ?? "Name haven't been set", attributes: attrubutes)
        
        return result
    }
    
    func setupSaveButton(){
        view.addSubview(saveButton)
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        saveButton.widthAnchor.constraint(equalTo: fullNameTextField.widthAnchor).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        saveButton.backgroundColor = .white
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.setTitle("Save", for: .normal)
        saveButton.layer.cornerRadius = 20
        
        saveButton.addTarget(nil, action: #selector(saveButtonAction), for: .touchUpInside)
    }
    
    @objc func saveButtonAction(){
        if let fullName = fullNameTextField.text, fullName != ""{
            Person.shared.fullName = fullName
        }
        Person.shared.age = agePickerView.selectedRow(inComponent: 0)
        
        let pdfCreater = PDFConfigurator()
        pdfCreater.createResultPDF()
        
        navigationController?.popViewController(animated: true)
        let viewController = navigationController?.viewControllers.last as? MainViewController
        viewController?.showSaveNotification = true
    }
    
}

extension EditPersonViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: String(describing: ages[row]), attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
        return attributedString
    }
    
}
