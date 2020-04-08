//
//  NavigationController.swift
//  Authentication
//
//  Created by David Sarkisyan on 06.04.2020.
//  Copyright © 2020 DavidS & that's all. All rights reserved.
//

import UIKit

extension UINavigationItem{
    func setup(type: ViewControllerType){
        rightBarButtonItems = UINavigationController.navigationBarButtons(type: type)
    }
}

extension UINavigationController {
    
    class func setupPersonViewButton() -> UIBarButtonItem{
        let image = UIImage(systemName: "book")
        let personViewButton = UIBarButtonItem(image: image, style: .plain, target: nil, action: #selector(personViewButtonAction))
        return personViewButton
    }
    
    @objc private func personViewButtonAction(){
        let data = PDFConfigurator.fetchLastFile()
        let viewController = PDFViewController(documentData: data)
        pushViewController(viewController, animated: true)
        
        navigationBar.barTintColor = .black
    }
    
    class func setupPersonEditButton() -> UIBarButtonItem{
        let image = UIImage(systemName: "pencil")
        let personViewButton = UIBarButtonItem(image: image, style: .plain, target: nil, action: #selector(personEditButtonAction))
        return personViewButton
    }
    
    @objc private func personEditButtonAction(){
        let viewController = EditPersonViewController()
        pushViewController(viewController, animated: true)
        
        navigationBar.barTintColor = .black
    }
    
}
