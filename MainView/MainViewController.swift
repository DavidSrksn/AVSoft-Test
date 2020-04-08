//
//  SignupViewController.swift
//  Authentication
//
//  Created by David Sarkisyan on 27.02.2020.
//  Copyright © 2020 DavidS & that's all. All rights reserved.
//

import UIKit

enum FontSize: CGFloat{
    case header =  35
    case description = 25
}

class MainViewController: UIViewController{
    var stackView = UIStackView()
    
    var alertIsShown: Bool = false
    var blurView = UIVisualEffectView()
    let finishLabel = UILabel()
        
    var showSaveNotification: Bool = false
    let savedNotificationLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        title = "Main"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        navigationItem.setup(type: .main)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .white
        cleanStackView()
        setupMainStackView()
        if !alertIsShown{
            setupBlurView()
            setupLabel()
            alertIsShown = true
        }
        if showSaveNotification{
            setupBlurView()
            setupSavedNotificationView()
            showSaveNotification = false
        }
    }
    
    func setupBlurView(){
        let blurEffect = UIBlurEffect(style: .regular)
        blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = view.safeAreaLayoutGuide.layoutFrame
        view.addSubview(blurView)
    }
    
    func setupLabel(){
        view.addSubview(finishLabel)
                
        finishLabel.translatesAutoresizingMaskIntoConstraints = false
        
        finishLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        finishLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        finishLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        finishLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        finishLabel.textAlignment = .center
        finishLabel.font = UIFont(name: "HelveticaNeue", size: 55)
        finishLabel.text = "Logged in \u{2713}"
        finishLabel.textColor = .black
        finishLabel.alpha = 0
        
        UIView.animate(withDuration: 1.2, animations: {
            self.finishLabel.alpha = 1
        }){ (bool) in
            UIView.animate(withDuration: 0.5, animations: {
                self.finishLabel.alpha = 0
            }) { (bool) in
                self.finishLabel.removeFromSuperview()
                self.blurView.removeFromSuperview()
            }
        }
    }
    
    func configurePeopleImageView() -> UILabel{
        let personImageLabel = UILabel()
                
        personImageLabel.layer.borderColor = UIColor.black.cgColor
        personImageLabel.layer.borderWidth = 3
        
        personImageLabel.text = "Photo"
        personImageLabel.textColor = .black
        personImageLabel.textAlignment = .center
        
        return personImageLabel
    }
    
    func configureLabel(label: UILabel?, fontSize: FontSize, text: ()->String) -> UILabel {
        let result: UILabel
        
        if label == nil{
            result = UILabel()
        }else{
            result = label!
        }
        
        result.textColor = .black
        result.font = UIFont(name: "HelveticaNeue", size: fontSize.rawValue)
        result.textAlignment = .left
        result.text = text()
        
        return result
    }
    
    func cleanStackView(){
        stackView.subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
    }
    
    func setupMainStackView(){
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 30
        
        stackView.tintColor = .black
        
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
        stackView.addArrangedSubview(configureLabel(label: nil, fontSize: .header, text: { () -> String in
            return "Personal Account"
        }))
        
        stackView.addArrangedSubview(componentHorizontalStackView())
        
        stackView.addArrangedSubview(configureLabel(label: nil, fontSize: .description, text: { () -> String in
            return "Full name: \(Person.shared.fullName ?? "Not stated")"
        }))
        
        stackView.addArrangedSubview(configureLabel(label: nil, fontSize: .description, text: { () -> String in
            if let login = Person.shared.login{
                return "Login: \(login)"
            }
            return "Login: Not stated"
        }))
        
        stackView.addArrangedSubview(configureLabel(label: nil, fontSize: .description, text: { () -> String in
            if  let password = Person.shared.password{
                return "Password: \(password)"
            }
            return "Password: Not stated"
        }))
    }
    
    func componentHorizontalStackView() -> UIStackView{
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.contentMode = .scaleAspectFit
        stackView.spacing = 40
        
        stackView.tintColor = .black
        
        let imageLabel = configurePeopleImageView()
        
        let ageLabel = configureLabel(label: nil, fontSize: .description) { () -> String in
            let age = (Person.shared.age != nil) ? "\(String(Person.shared.age!))" : "No"
            
            return "Age: \(age)"
        }
        
        stackView.addArrangedSubview(imageLabel)
        stackView.addArrangedSubview(ageLabel)
        
        return stackView
    }
    
    func setupSavedNotificationView(){
        view.addSubview(savedNotificationLabel)
        
        savedNotificationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        savedNotificationLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        savedNotificationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        savedNotificationLabel.widthAnchor.constraint(equalToConstant: view.frame.width ).isActive = true
        savedNotificationLabel.heightAnchor.constraint(equalToConstant: view.frame.width * 0.45).isActive = true

        savedNotificationLabel.alpha = 0
        savedNotificationLabel.textColor = .black

        savedNotificationLabel.textAlignment = .center
        savedNotificationLabel.font = UIFont(name: "HelveticaNeue", size: 55)
        savedNotificationLabel.text = "Saved  \u{2713}"
        
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: UIView.KeyframeAnimationOptions.calculationModeLinear, animations: {
            self.savedNotificationLabel.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 2, animations: {
            self.savedNotificationLabel.alpha = 0
        }) { (bool) in
            self.blurView.removeFromSuperview()
            self.savedNotificationLabel.removeFromSuperview()
        }
    }
    
    
}
