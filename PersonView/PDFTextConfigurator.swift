//
//  PDFTextConfigurator.swift
//  Authentication
//
//  Created by David Sarkisyan on 08.04.2020.
//  Copyright © 2020 DavidS & that's all. All rights reserved.
//

class PDFTextConfigurator {
    
    let leftTabSize = "\t"
    let rightTabSize = ":   "
    
    func setupPage() -> String{
        var body: String = ""
        
        if let fullName = Person.shared.fullName{
            body += "Full Name : \(fullName)\n"
        }else{
            body += "Full Name : Not stated \n"
        }
        
        if let age = Person.shared.age{
            body += "Age : \(age) \n"
        }else{
            body += "Age : Not stated \n"
        }
        
        return body
    }
    
}
