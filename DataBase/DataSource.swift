//
//  DataSource.swift
//  Authentication
//
//  Created by David Sarkisyan on 27.02.2020.
//  Copyright © 2020 DavidS & that's all. All rights reserved.
//

import Foundation

public enum PersonData: String{  // строка - это ключ
    case login = "login"
    case password = "password"
}

final class DataSource{
    static let shared = DataSource()
        
    func checkData(data: String? , key: PersonData) -> Bool{
       return data == getData(key: key)
    }
    
    func getData(key: PersonData) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }
    
    func createNewPerson(login: String, password: String){
        UserDefaults.standard.set(login, forKey: "login")
        UserDefaults.standard.set(password, forKey: "password")
    }
}
    
