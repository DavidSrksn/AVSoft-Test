//
//  SignupPresenter.swift
//  Authentication
//
//  Created by David Sarkisyan on 29.02.2020.
//  Copyright © 2020 DavidS & that's all. All rights reserved.
//

protocol SignupPresenterProtocol {
    init(viewController: SignupViewControllerProtocol)
}

class SignupPresenter:  SignupPresenterProtocol {
    
    unowned let view: SignupViewControllerProtocol
    
    required init(viewController: SignupViewControllerProtocol) {
        self.view = viewController
    }
    
    func showAlertWarning(message: String){
        view.setAlertWarning(message: message)
    }
    
    func showShimmerWarning(textfieldType: PersonData){
        view.setShimmerWarning(textfieldType: textfieldType)
    }
    
    func presentViewController(occasion: AuthStatus){
        
        view.presentViewController(viewController: occasion.rawValue)
    }
}

