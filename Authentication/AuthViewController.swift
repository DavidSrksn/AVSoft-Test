//
//  ViewController.swift
//  Authentication
//
//  Created by David Sarkisyan on 25.02.2020.
//  Copyright © 2020 DavidS & that's all. All rights reserved.
//

import UIKit

protocol AuthViewProtocol: class{
    var progressBar: ProgressView {get set}
    
    func setAlertWarning(message: String)
    
    func setShimmerWarning(textfieldType: PersonData)
    
    func presentViewController(viewController: UIViewController)
    
}

final class AuthViewController: UIViewController, UITextFieldDelegate, AuthViewProtocol {

    var presenter: AuthPresenter!
    
    var progressBar = ProgressView(frame: .zero, progressNumber: 2)
    
    let dataSource = DataSource.shared
    
    let stackView = UIStackView()
    
    let loginTextField = UITextField()
    let passwordTextField = UITextField()
    
    let loginButton = UIButton()
    let signupButton = UIButton()
    
    let logoLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMVP()
        setupKeyboardLayout()
        loginTextField.delegate = self
        passwordTextField.delegate = self
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupTextField(textField: loginTextField, placeHolder: "Login")
        setupTextField(textField: passwordTextField, placeHolder: "Password")
        setupStackVIew()
        setupLoginButton()
        setupSignupButton()
        setupProgressBar()
        setupLogo()
    }
    
    func setupMVP(){
        let presenter = AuthPresenter(viewController: self)
        self.presenter = presenter
    }
    
    func presentViewController(viewController: UIViewController) {
        self.present(viewController, animated: true)
    }
    
    func setAlertWarning(message: String) {
        showWarning(message: message)
    }
    
    func setShimmerWarning(textfieldType: PersonData) {
        switch textfieldType {
        case .login:
            loginTextField.warning()
        case .password:
            passwordTextField.warning()
        }
    }
    
    func changeStatus(textField: UITextField, key: PersonData) {
        if textField.text! == "" {
            textField.status = .empty
        }else if textField.isCorrect(key: key){
            textField.status = .correct
        }else if !textField.isCorrect(key: key){
            textField.status = .incorrect
        }
    }
    
    func setupTextField(textField: UITextField, placeHolder: String){
        textField.attributedPlaceholder = NSAttributedString(string: placeHolder,attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.darkGray.cgColor
        
        textField.textColor = .black
        
        stackView.addArrangedSubview(textField)
    }
    
    func setupStackVIew(){
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        stackView.tintColor = .black
        
        stackView.layer.borderColor = UIColor.black.cgColor
        stackView.layer.borderWidth = 5
        stackView.layer.cornerRadius = loginTextField.layer.cornerRadius
        
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: stackView.bounds.height).isActive = true
        
        stackView.arrangedSubviews.last?.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        stackView.arrangedSubviews.first?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    func setupLogo(){
        view.addSubview(logoLabel)
        
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        logoLabel.bottomAnchor.constraint(equalTo: progressBar.topAnchor, constant: -5).isActive = true
        logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        logoLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        logoLabel.textAlignment = .center
        logoLabel.font = UIFont(name: "HelveticaNeue", size: 30)
        logoLabel.text = "Authentication"
        logoLabel.textColor = .black
    }

    func setupLoginButton(){
        loginButton.addTarget(.none, action: #selector(loginButtonAction), for: .touchUpInside)
        view.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        loginButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 20)
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        
        loginButton.alpha = 0.5
        
        loginButton.layer.cornerRadius = loginTextField.layer.cornerRadius
        loginButton.backgroundColor = .black
    }
    
    @objc func loginButtonAction(){
        let login = loginTextField.text!
        let password = passwordTextField.text!
        
        if login == "", password == "" {
            presenter.showAlertWarning(message: "Filled fields are incorrect")
        }else if !dataSource.checkData(data: login, key: .login) && !dataSource.checkData(data: password, key: .password){
            presenter.showShimmerWarning(textfieldType: .login)
            presenter.showShimmerWarning(textfieldType: .password)
        }else if !dataSource.checkData(data: password, key: .password){
            presenter.showShimmerWarning(textfieldType: .password)
        }else if !dataSource.checkData(data: login, key: .login){
            presenter.showShimmerWarning(textfieldType: .login)
        }else{
            Person.shared.login = login
            Person.shared.password = password
            
            let viewController = AuthStatus.loggedIn.rawValue
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true, completion: nil)
        }
    }
    
    func setupProgressBar(){
        view.addSubview(progressBar)
        
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        
        progressBar.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -30).isActive = true
        progressBar.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        progressBar.heightAnchor.constraint(equalToConstant: 10).isActive = true
    }
    
    func setupSignupButton(){
        signupButton.addTarget(.none, action: #selector(signupButtonAction), for: .touchUpInside)
        view.addSubview(signupButton)
        
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        
        signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10).isActive = true
        signupButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signupButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        signupButton.setTitle("Sign up", for: .normal)
        signupButton.setTitleColor(.systemBlue, for: .normal)
        signupButton.titleLabel?.textAlignment = .center
    }
    
    @objc func signupButtonAction(){
        presenter.presentViewController(occasion: .shouldSignUp)
    }
    
}



extension AuthViewController {

    private func keyForTextfield(textField: UITextField) -> PersonData{
        if textField === loginTextField{
            return .login
        }else if textField === passwordTextField{
            return .password
        }else{return .login}
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        switch textField.status{
        case .correct:
            return
        case .incorrect, .empty:
            progressBar.updateProgress(occasion: .increase) {
                UIView.animate(withDuration: 1) {
                    self.loginButton.alpha = 1
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        let key = keyForTextfield(textField: textField)
        
        changeStatus(textField: textField, key: key)
        
        switch textField.status{
        case .correct:
            return
        case .incorrect, .empty:
            progressBar.updateProgress(occasion: .reduce) {
                UIView.animate(withDuration: 1) {
                    self.loginButton.alpha = 0.5
                }
            }
        }
    }
    
}


// MARK: Keyboard layput

extension AuthViewController{
    @objc func keyboardWillShow(notification: NSNotification){
        guard let userInfo = notification.userInfo else{return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else{return}
        let keyboardFrame = keyboardSize.cgRectValue.height
        
        if view.frame.origin.y == 0{
            view.frame.origin.y -= keyboardFrame / 2.5
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        if view.frame.origin.y != 0{
            view.frame.origin.y = 0
        }
    }
    
    public func setupKeyboardLayout(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}
