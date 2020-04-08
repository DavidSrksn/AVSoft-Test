//
//  NavigationBarButtonSetup.swift
//  Authentication
//
//  Created by David Sarkisyan on 06.04.2020.
//  Copyright © 2020 DavidS & that's all. All rights reserved.
//
import UIKit

enum ViewControllerType {
    case main
}
extension UINavigationController{
    class func navigationBarButtons(type: ViewControllerType) -> [UIBarButtonItem] {
        switch type{
        case .main:
            return [setupPersonEditButton(), setupPersonViewButton()]
        }
    }
}
