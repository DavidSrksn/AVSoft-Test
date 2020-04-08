//
//  Auth.swift
//  Authentication
//
//  Created by David Sarkisyan on 27.02.2020.
//  Copyright © 2020 DavidS & that's all. All rights reserved.
//

import UIKit

public enum AuthStatus{
    case loggedIn
    case shouldSignUp
    case signedUp
}

extension AuthStatus: RawRepresentable{
    public typealias RawValue = UIViewController
    
    public init?(rawValue: RawValue) {
        switch rawValue {
        case MainViewController(): self = .loggedIn
        case SignupViewController(): self = .shouldSignUp
        case AuthViewController(): self = .signedUp
        default: return nil
        }
    }
    
    public var rawValue: RawValue {
        switch self {
        case .loggedIn: return MainViewController()
        case .shouldSignUp: return SignupViewController()
        case .signedUp: return AuthViewController()
        }
    }
}
