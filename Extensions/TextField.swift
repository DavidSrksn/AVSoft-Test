//
//  TextField.swift
//  Authentication
//
//  Created by David Sarkisyan on 26.02.2020.
//  Copyright © 2020 DavidS & that's all. All rights reserved.
//

import UIKit



extension UITextField{
    public func isCorrect(key: PersonData) -> Bool{
        if let userData = DataSource.shared.getData(key: key), userData == text{
            return true
        }else {
            return false
        }
    }
}

// MARK: TextField status

enum TextFieldStatus{
    case correct
    case incorrect
    case empty
}


enum AssociatedKeys {
    static var status: TextFieldStatus = .empty
}

extension UITextField{
     var status: TextFieldStatus {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.status) as? TextFieldStatus ?? TextFieldStatus.empty
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.status, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
