//
//  Warning.swift
//  Authentication
//
//  Created by David Sarkisyan on 26.02.2020.
//  Copyright © 2020 DavidS & that's all. All rights reserved.
//

import UIKit

extension UIViewController{
    public func showWarning(message: String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension UITextField{
    
    public func warning(){
        let originalColor = self.backgroundColor
        
        UIView.animate(withDuration: 1) {
            self.backgroundColor = .systemRed
        }
        UIView.animate(withDuration: 1) {
            self.backgroundColor = originalColor
        }

    }
}

