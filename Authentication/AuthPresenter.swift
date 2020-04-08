//
//  AuthPresenter.swift
//  Authentication
//
//  Created by David Sarkisyan on 27.02.2020.
//  Copyright © 2020 DavidS & that's all. All rights reserved.
//
import UIKit

protocol AuthPresenterProtocol {
    init(viewController: AuthViewProtocol)
    
    func showAlertWarning(message: String)
    
    func showShimmerWarning(textfieldType: PersonData)
    
    func presentViewController(occasion: AuthStatus)
}

class AuthPresenter:  AuthPresenterProtocol {
    
    unowned let view: AuthViewProtocol
    
    required init(viewController: AuthViewProtocol) {
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
