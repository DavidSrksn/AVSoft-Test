//
//  File.swift
//  Authentication
//
//  Created by David Sarkisyan on 26.02.2020.
//  Copyright © 2020 DavidS & that's all. All rights reserved.
//

import UIKit

fileprivate enum SignupTextField{ // для delegate
    case login
    case password
    case repeatPassword
}

protocol SignupViewControllerProtocol: class{
    
    func setAlertWarning(message: String)
    
    func setShimmerWarning(textfieldType: PersonData)
    
    func presentViewController(viewController: UIViewController)
    
    func createNewPerson()
}

final class SignupViewController: UIViewController, UITextFieldDelegate,
SignupViewControllerProtocol{
    
    var presenter: SignupPresenter!
       
    let scrollView = UIScrollView()
        
    let headerLabel = UILabel()
        
    let mainStackView = UIStackView()
    
    let loginTextField = UITextField()
    let passwordTextField = UITextField()
    let repeatPasswordTextField = UITextField()
    
    let loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMVP()
        setupKeyboardLayout()
        loginTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupScrollView()
        view.backgroundColor = .white
        setupHeader()
        setupMainStackView()
        setupLoginButton()
    }
    
    func setupMVP(){
        let presenter = SignupPresenter(viewController: self)
        self.presenter = presenter
    }
    
    func presentViewController(viewController: UIViewController) {
        self.modalTransitionStyle = .coverVertical
        self.present(viewController, animated: true, completion: nil)
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
            repeatPasswordTextField.warning()
        }
    }
    
    func createNewPerson(){
        let login = loginTextField.text!
        let password = passwordTextField.text!
        
        Person.shared.login = login
        Person.shared.password = password
        
        DataSource.shared.createNewPerson(login: login, password: password)
    }
    
    func setupScrollView(){
        view.addSubview(scrollView)
        
        scrollView.frame = view.frame
        scrollView.contentSize.height = 1
        scrollView.backgroundColor = .clear
    }
    
    func passwordsMatch() -> Bool{
        if passwordTextField.text == repeatPasswordTextField.text{
            return true
        }else{ return false }
    }
    
    fileprivate func changeStatus(textField: UITextField) {
        if textField.text! == "" {
            textField.status = .empty
        }else if textField.text!.isAllowed(){
            textField.status = .correct
        }else if !textField.text!.isAllowed(){
            textField.status = .incorrect
        }
    }
    
    func setupLoginButton(){
        loginButton.addTarget(.none, action: #selector(loginButtonAction), for: .touchUpInside)
        
        scrollView.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalTo: mainStackView.widthAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 40).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        loginButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 20)
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        
        loginButton.alpha = 0.25
        
        loginButton.layer.cornerRadius = loginTextField.layer.cornerRadius
        loginButton.backgroundColor = .black
    }
    
    @objc func loginButtonAction(){
        let login = loginTextField.text!
        let password = passwordTextField.text!
        let repeatPassword = repeatPasswordTextField.text!

        if login == "" && password == "" && repeatPassword == "" {
            presenter.showAlertWarning(message: "Filled fields are incorrect")
        }else if !login.isAllowed() || login == ""{
            presenter.showShimmerWarning(textfieldType: .login)
        }else if !password.isAllowed() || password == ""{
            presenter.showShimmerWarning(textfieldType: .password)
        }else if !passwordsMatch(){
            presenter.showShimmerWarning(textfieldType: .password)
        }else{
            createNewPerson()
            let viewController = AuthStatus.loggedIn.rawValue
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true, completion: nil)
        }
    }
    
    func setupHeader(){
        scrollView.addSubview(headerLabel)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        headerLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        headerLabel.widthAnchor.constraint(equalToConstant: scrollView.frame.width).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        headerLabel.textColor = .black
        headerLabel.font = UIFont(name: "HelveticaNeue", size: 45)
        headerLabel.text = "Registration"
        headerLabel.textAlignment = .center
    }
    
    func setupTextField(textField: UITextField,placeHolder: String) {
        textField.attributedPlaceholder = NSAttributedString(string: placeHolder,attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.darkGray.cgColor
        
        textField.textColor = .black
    }
    
    func textFieldHeaderLabel(text: String) -> UILabel{
        let headerOfTextFireld = UILabel()
        
        headerOfTextFireld.textColor = .black
        headerOfTextFireld.font = UIFont(name: "HelveticaNeue", size: 30)
        headerOfTextFireld.textAlignment = .left
        headerOfTextFireld.text = text
        
        return headerOfTextFireld
    }
    
    func setupMainStackView(){
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.spacing = 50
        
        mainStackView.tintColor = .black
        
        scrollView.addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        mainStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        mainStackView.widthAnchor.constraint(equalToConstant: scrollView.frame.width * 0.8).isActive = true
        mainStackView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        mainStackView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20).isActive = true
        
        mainStackView.addArrangedSubview(componentStackView(textField: loginTextField, headerLabelText: "Login"))
        mainStackView.addArrangedSubview(componentStackView(textField: passwordTextField, headerLabelText: "Password"))
        mainStackView.addArrangedSubview(componentStackView(textField: repeatPasswordTextField, headerLabelText: "Repeat password"))
    }
    
    func componentStackView(textField: UITextField, headerLabelText: String) -> UIStackView{
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 20
        
        stackView.tintColor = .black
        
        stackView.addArrangedSubview(textFieldHeaderLabel(text: headerLabelText))
        
        setupTextField(textField: textField, placeHolder: headerLabelText)
        stackView.addArrangedSubview(textField)
        
        return stackView
    }
}

//MARK: TextFieldDelegate

extension SignupViewController {

    private func keyForTextfield(textField: UITextField) -> PersonData{
        if textField === loginTextField{
            return .login
        }else if textField === passwordTextField || textField === repeatPasswordTextField{
            return .password
        }else{return .login}
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        if textField.status == .empty{
            UIView.animate(withDuration: 1) {
                self.loginButton.alpha += 0.25
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        changeStatus(textField: textField)
        
        switch textField.status{
        case .correct:
            return
        case .incorrect, .empty:
            UIView.animate(withDuration: 1) {
                self.loginButton.alpha -= 0.25
            }
        }
    }
    
}

// MARK: Keyboard layput

extension SignupViewController{
    @objc func keyboardWillShow(notification: NSNotification){
        guard let userInfo = notification.userInfo else{return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else{return}
        let keyboardFrame = keyboardSize.cgRectValue.height
        
        if view.frame.origin.y == 0{
            view.frame.origin.y -= keyboardFrame / 2.3
            scrollView.contentSize.height = view.frame.height + keyboardFrame / 1.5
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        view.frame.origin.y = 0
        self.scrollView.contentSize.height = 1.0
    }
    
    public func setupKeyboardLayout(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}
