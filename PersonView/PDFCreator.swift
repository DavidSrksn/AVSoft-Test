//
//  PDFCreator.swift
//  Authentication
//
//  Created by David Sarkisyan on 08.04.2020.
//  Copyright © 2020 DavidS & that's all. All rights reserved.
//

import PDFKit
import UIKit

class PDFConfigurator{
    var image: UIImage {
        if let image = UIImage(named: "АВСОФТ_190411_сас_АРПП_Актуализация информации на сайте_Логотип_v1.0"){
            return image
        }
        return UIImage(systemName: "plus")!
    }
    
    let title: String = "Профиль"
    let body: String
    
    static let path: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    init(){
        let pdfTextConfigurator = PDFTextConfigurator()
        self.body = pdfTextConfigurator.setupPage()
    }
    
    func createResultPDF() -> Data {
        
        let pdfMetaData = [
            kCGPDFContextTitle: title
        ]
        
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        let pageWidth = 8.5 * 72.0
        let pageHeight = 11 * 72.0
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)

        let data = renderer.pdfData { (context) in
            context.beginPage()

            let imageBottom: CGFloat = addImage(pageRect: pageRect)
            let titleBottom = addTitle(pageRect: pageRect,topAnchor: imageBottom + 10)
            addBodyText(pageRect: pageRect, textTop: titleBottom + 20.0)
        }
        
        saveViewPdf(data: data)
        
        return data
    }
    
    func saveViewPdf(data: Data) {
        let now = Date()
        let pdfPath = PDFConfigurator.path.appendingPathComponent("\(now.description).pdf")

        do {
            try data.write(to: URL(fileURLWithPath: pdfPath.path))
        }catch{
            print("беда - не получилось (но это не про меня, так что вряд ли :D)")
        }
    }

    func addTitle(pageRect: CGRect, topAnchor: CGFloat) -> CGFloat {

        let titleFont = UIFont.systemFont(ofSize: 25.0, weight: .bold)

        let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]
        let attributedTitle = NSAttributedString(string: title, attributes: titleAttributes)

        let titleStringSize = attributedTitle.size()

        let titleStringRect = CGRect(x: (pageRect.width - titleStringSize.width) / 2.0,
                                     y: topAnchor, width: titleStringSize.width,
                                     height: titleStringSize.height)

        attributedTitle.draw(in: titleStringRect)

        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    func addBodyText(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 22.0, weight: .regular)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping

        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: body, attributes: textAttributes)

        let textRect = CGRect(x: 10, y: textTop, width: pageRect.width - 20,
                              height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: textRect)
    }
    
    func addImage(pageRect: CGRect) -> CGFloat {
        let maxHeight = pageRect.height * 0.3
        let maxWidth = pageRect.width * 0.25

        let aspectWidth = maxWidth / image.size.width
        let aspectHeight = maxHeight / image.size.height
        let aspectRatio = min(aspectWidth, aspectHeight)

        let scaledWidth = image.size.width * aspectRatio
        let scaledHeight = image.size.height * aspectRatio

        let imageX = pageRect.width - scaledWidth - 10
        let imageY: CGFloat = 10
        
        let imageRect = CGRect(x: imageX, y: imageY,
                               width: scaledWidth, height: scaledHeight)

        image.draw(in: imageRect)
        return imageRect.origin.y + imageRect.size.height
    }
    
    static func fetchLastFile() ->  Data?{
        let fm = FileManager.default
        let pdfPath: String = PDFConfigurator.path.path
        do{
            let paths = try fm.contentsOfDirectory(atPath: pdfPath).sorted()
            
            if let path = paths.last, let item =  fm.contents(atPath: pdfPath + "/" + path){
                let file =  item
                return file
            }
        }catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
}

