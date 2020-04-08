//
//  AuthModel.swift
//  Authentication
//
//  Created by David Sarkisyan on 25.02.2020.
//  Copyright © 2020 DavidS & that's all. All rights reserved.
//

public struct Person{
    static var shared = Person()
    
    var login: String?
    var password: String?
    
    var fullName: String?
    var age: Int?
}
