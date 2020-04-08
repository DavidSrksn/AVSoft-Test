//
//  Text.swift
//  Authentication
//
//  Created by David Sarkisyan on 01.03.2020.
//  Copyright © 2020 DavidS & that's all. All rights reserved.
//

extension String{
    public func isAllowed() -> Bool{
        var flag: Int = 0
        
        self.forEach({ (character) in
            let symbol = "\(character)"
            if unpermittedSymbols.contains(symbol){
                flag = 1
            }
        })
        
        if flag == 0 || self == ""{
            return true
        }else{
            return false
        }
    }
}
