//
//  ProgressView.swift
//  Authentication
//
//  Created by David Sarkisyan on 26.02.2020.
//  Copyright © 2020 DavidS & that's all. All rights reserved.
//

import UIKit

enum ProgressType {
    case increase
    case reduce
}

final class ProgressView: UIProgressView{
    
    var progressNumber: Float
    
    required init(frame: CGRect, progressNumber: Float) {
        self.progressNumber = progressNumber
        super.init(frame: frame)
        setupProgressView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateProgress(occasion: ProgressType, completion: (()-> Void)?){
        let progress: Float
        switch occasion {
        case .increase:
            progress = self.progress + Float(1) / progressNumber
        case .reduce:
            progress = self.progress - Float(1) / progressNumber
        }
        self.setProgress(progress, animated: true)
        
        checkProgress(occasion: occasion, completion: completion)
    }
    
    private func setupProgressView(){
        tintColor = .black
        trackTintColor = .clear
        
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        
        layer.cornerRadius = 5
    }
    
    private func checkProgress(occasion: ProgressType, completion: (()->Void)?){
        switch occasion{
        case .increase:
            if progress == 1{
                completion?()
            }
        case .reduce:
            completion?()
        }
    }
    
}
