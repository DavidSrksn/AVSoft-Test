//
//  PersonViewViewController.swift
//  Authentication
//
//  Created by David Sarkisyan on 06.04.2020.
//  Copyright © 2020 DavidS & that's all. All rights reserved.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController{
    
    var documentData: Data?
    let pdfView = PDFView()
    
    let shareButton = UIButton()
    
    init(documentData: Data?) {
        self.documentData = documentData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        if let data = documentData {
          pdfView.document = PDFDocument(data: data)
          pdfView.autoScales = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pdfView.backgroundColor = .black
        setupPDFView()
        if UIDevice.current.userInterfaceIdiom == .phone { 
            setupShareButton()
        }
    }
    
    func setupPDFView(){
        view.addSubview(pdfView)
        
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        
        pdfView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        pdfView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func setupShareButton(){
        view.addSubview(shareButton)
        shareButton.addTarget(nil, action: #selector(sharePDF), for: .touchUpInside)
        
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        
        shareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        shareButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.5).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        shareButton.setTitle("Поделиться", for: .normal)
        shareButton.setTitleColor( .black, for: .normal)
        
        shareButton.backgroundColor = .white
        shareButton.layer.cornerRadius = 20
        shareButton.layer.borderColor = UIColor.black.cgColor
        shareButton.layer.borderWidth = 1
    }
    
    @objc func sharePDF(){
        if let data = documentData{
        let activityController = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
        }
    }
    
}

