//
//  PDFCreator.swift
//  Projet_SEIO
//
//  Created by Romain Rabouan on 23/06/2021.
//

import PDFKit

class PDFCreator: NSObject {
    let title: String
    let patientName: String
    let image: UIImage
    let practicienEmail: String
    let finalScoreString: String
    let finalScoreResult: String
    
    init(title: String, patientName: String, image: UIImage, practicienEmail: String, finalScoreString: String, finalScoreResult: String) {
        self.title = title
        self.patientName = patientName
        self.image = image
        self.practicienEmail = practicienEmail
        self.finalScoreString = finalScoreString
        self.finalScoreResult = finalScoreResult
    }
    
    func createPage() -> Data {
        let pdfMetaData = [
            kCGPDFContextCreator: "Application diagnostic du genou",
            kCGPDFContextAuthor: practicienEmail,
            kCGPDFContextTitle: title
        ]
        
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        // A4
        let pageWidth = 8.5 * 72.0
        let pageHeight = 11 * 72.0
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
        let rep1 = UserDefaults.standard.string(forKey: "reponse0") ?? "-"
        let rep2 = UserDefaults.standard.string(forKey: "reponse1") ?? "-"
        let rep3 = UserDefaults.standard.string(forKey: "reponse2") ?? "-"
        let rep4 = UserDefaults.standard.string(forKey: "reponse3") ?? "-"
        let rep5 = UserDefaults.standard.string(forKey: "reponse4") ?? "-"
        
        let int1 = UserDefaults.standard.string(forKey: "intitule0") ?? ""
        let int2 = UserDefaults.standard.string(forKey: "intitule1") ?? ""
        let int3 = UserDefaults.standard.string(forKey: "intitule2") ?? ""
        let int4 = UserDefaults.standard.string(forKey: "intitule3") ?? ""
        let int5 = UserDefaults.standard.string(forKey: "intitule4") ?? ""
        
        let data = renderer.pdfData { context in
            context.beginPage()
            
            let titleTop = addTitle(pageRect: pageRect)
            let imageTop = addImage(pageRect: pageRect, imageTop: titleTop + 25.0)
            let patientTop = addPatientName(pageRect: pageRect, textTop: imageTop + 30.0)
            let doctorTop = addDoctorEmail(pageRect: pageRect, textTop: patientTop + 20.0)
            let dateLabel = addDateLabel(pageRect: pageRect, textTop: doctorTop + 20.0)
            let scoreTop = addScore(pageRect: pageRect, textTop: dateLabel + 20.0)
            let doctorInfoTop = addTextInfo(pageRect: pageRect, textTop: scoreTop + 20.0)
            let question1 = addQuestionResult(pageRect: pageRect, textTop: doctorInfoTop + 20.0, title: int1, result: rep1, questionNbr: 1)
            let question2 = addQuestionResult(pageRect: pageRect, textTop: question1 + 20.0, title: int2, result: rep2, questionNbr: 2)
            let question3 = addQuestionResult(pageRect: pageRect, textTop: question2 + 20.0, title: int3, result: rep3, questionNbr: 3)
            let question4 = addQuestionResult(pageRect: pageRect, textTop: question3 + 20.0, title: int4, result: rep4, questionNbr: 4)
            let question5 = addQuestionResult(pageRect: pageRect, textTop: question4 + 20.0, title: int5, result: rep5, questionNbr: 5)
            addDisclaimer(pageRect: pageRect, textTop: question5 + 40)
        }
        
        return data
    }
    
    func createPage(with password: String, userPassword: String) -> Data {
        let pdfMetaData = [
            kCGPDFContextCreator: "Application diagnostic du genou",
            kCGPDFContextAuthor: practicienEmail,
            kCGPDFContextTitle: title,
            kCGPDFContextUserPassword: userPassword,
            kCGPDFContextOwnerPassword: password
        ]
        
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        // A4
        let pageWidth = 8.5 * 72.0
        let pageHeight = 11 * 72.0
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
        let rep1 = UserDefaults.standard.string(forKey: "reponse0") ?? "-"
        let rep2 = UserDefaults.standard.string(forKey: "reponse1") ?? "-"
        let rep3 = UserDefaults.standard.string(forKey: "reponse2") ?? "-"
        let rep4 = UserDefaults.standard.string(forKey: "reponse3") ?? "-"
        let rep5 = UserDefaults.standard.string(forKey: "reponse4") ?? "-"
        
        let int1 = UserDefaults.standard.string(forKey: "intitule0") ?? ""
        let int2 = UserDefaults.standard.string(forKey: "intitule1") ?? ""
        let int3 = UserDefaults.standard.string(forKey: "intitule2") ?? ""
        let int4 = UserDefaults.standard.string(forKey: "intitule3") ?? ""
        let int5 = UserDefaults.standard.string(forKey: "intitule4") ?? ""
                
        let data = renderer.pdfData { context in
            context.beginPage()
            
            let titleTop = addTitle(pageRect: pageRect)
            let imageTop = addImage(pageRect: pageRect, imageTop: titleTop + 25.0)
            let patientTop = addPatientName(pageRect: pageRect, textTop: imageTop + 30.0)
            let doctorTop = addDoctorEmail(pageRect: pageRect, textTop: patientTop + 20.0)
            let dateLabel = addDateLabel(pageRect: pageRect, textTop: doctorTop + 20.0)
            let scoreTop = addScore(pageRect: pageRect, textTop: dateLabel + 20.0)
            let doctorInfoTop = addTextInfo(pageRect: pageRect, textTop: scoreTop + 20.0)
            let question1 = addQuestionResult(pageRect: pageRect, textTop: doctorInfoTop + 20.0, title: int1, result: rep1, questionNbr: 1)
            let question2 = addQuestionResult(pageRect: pageRect, textTop: question1 + 20.0, title: int2, result: rep2, questionNbr: 2)
            let question3 = addQuestionResult(pageRect: pageRect, textTop: question2 + 20.0, title: int3, result: rep3, questionNbr: 3)
            let question4 = addQuestionResult(pageRect: pageRect, textTop: question3 + 20.0, title: int4, result: rep4, questionNbr: 4)
            let question5 = addQuestionResult(pageRect: pageRect, textTop: question4 + 20.0, title: int5, result: rep5, questionNbr: 5)
            addDisclaimer(pageRect: pageRect, textTop: question5 + 40)

        }
        
        return data
    }
    
    func addImage(pageRect: CGRect, imageTop: CGFloat) -> CGFloat {
        let maxHeight = pageRect.height * 0.2
        let maxWidth = pageRect.width * 0.2
        
        let aspectWidth = maxWidth / image.size.width
        let aspectHeight = maxHeight / image.size.height
        let aspectRatio = min(aspectWidth, aspectHeight)
        
        let scaledWidth = image.size.width * aspectRatio
        let scaledHeight = image.size.height * aspectRatio
        
        let imageX = (pageRect.width - scaledWidth) / 2.0
        let imageRect = CGRect(x: imageX, y: imageTop,
                               width: scaledWidth, height: scaledHeight)
        image.draw(in: imageRect)
        
        return imageRect.origin.y + imageRect.size.height
    }
    
    func addTitle(pageRect: CGRect) -> CGFloat {
        let titleFont = UIFont.systemFont(ofSize: 21.0, weight: .bold)
        let titleAttributes: [NSAttributedString.Key: Any] =
          [NSAttributedString.Key.font: titleFont]
        let attributedTitle = NSAttributedString(string: title, attributes: titleAttributes)
        let titleStringSize = attributedTitle.size()
        let titleStringRect = CGRect(x: (pageRect.width - titleStringSize.width) / 2.0,
                                     y: 36, width: titleStringSize.width,
                                     height: titleStringSize.height)
        attributedTitle.draw(in: titleStringRect)
        
        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    func addPatientName(pageRect: CGRect, textTop: CGFloat) -> CGFloat {
        let titleFont = UIFont.systemFont(ofSize: 15.0)
        let titleAttributes: [NSAttributedString.Key: Any] =
          [NSAttributedString.Key.font: titleFont]
        let loc = String(format: NSLocalizedString("Nom du patient : %@", comment: ""), patientName)
        let attributedTitle = NSAttributedString(string: loc, attributes: titleAttributes)
        let titleSize = attributedTitle.size()
        let titleStringRect = CGRect(x: 20, y: textTop, width: pageRect.width - 20, height: titleSize.height)
        attributedTitle.draw(in: titleStringRect)
        
        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    func addDoctorEmail(pageRect: CGRect, textTop: CGFloat) -> CGFloat {
        let titleFont = UIFont.systemFont(ofSize: 15.0)
        let titleAttributes: [NSAttributedString.Key: Any] =
          [NSAttributedString.Key.font: titleFont]
        let loc = String(format: NSLocalizedString("Email du praticien : %@", comment: ""), practicienEmail)
        let attributedTitle = NSAttributedString(string: loc, attributes: titleAttributes)
        let titleSize = attributedTitle.size()
        let titleStringRect = CGRect(x: 20, y: textTop, width: pageRect.width - 20, height: titleSize.height)
        attributedTitle.draw(in: titleStringRect)
        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    func addDateLabel(pageRect: CGRect, textTop: CGFloat) -> CGFloat {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: date)
        
        let titleFont = UIFont.systemFont(ofSize: 15.0)
        let titleAttributes: [NSAttributedString.Key: Any] =
          [NSAttributedString.Key.font: titleFont]
        let localizedStringDoctorEmail = "Date : \(dateString)"
        let attributedTitle = NSAttributedString(string: localizedStringDoctorEmail, attributes: titleAttributes)
        let titleSize = attributedTitle.size()
        let titleStringRect = CGRect(x: 20, y: textTop, width: pageRect.width - 20, height: titleSize.height)
        attributedTitle.draw(in: titleStringRect)
        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    func addScore(pageRect: CGRect, textTop: CGFloat) -> CGFloat {
        let titleFont = UIFont.boldSystemFont(ofSize: 15.0)
        let titleAttributes: [NSAttributedString.Key: Any] =
          [NSAttributedString.Key.font: titleFont]
        let attributedTitle = NSAttributedString(string: "Score : \(finalScoreResult)", attributes: titleAttributes)
        let titleSize = attributedTitle.size()
        let titleStringRect = CGRect(x: 20, y: textTop, width: pageRect.width - 20, height: titleSize.height)
        attributedTitle.draw(in: titleStringRect)
        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    func addTextInfo(pageRect: CGRect, textTop: CGFloat) -> CGFloat {
        let titleFont = UIFont.systemFont(ofSize: 15.0)
        let titleAttributes: [NSAttributedString.Key: Any] =
          [NSAttributedString.Key.font: titleFont]
        let attributedTitle = NSAttributedString(string: NSLocalizedString("Résultats :", comment: ""), attributes: titleAttributes)
        let titleSize = attributedTitle.size()
        let titleStringRect = CGRect(x: 20, y: textTop, width: pageRect.width - 20, height: titleSize.height)
        attributedTitle.draw(in: titleStringRect)
        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    func addQuestionResult(pageRect: CGRect, textTop: CGFloat, title: String, result: String, questionNbr: Int) -> CGFloat {
        let titleFont = UIFont.systemFont(ofSize: 15.0)
        let titleAttributes: [NSAttributedString.Key: Any] =
          [NSAttributedString.Key.font: titleFont]
        let attributedTitle = NSAttributedString(string: "Question \(questionNbr) (\(title)) : \(result)", attributes: titleAttributes)
        let titleSize = attributedTitle.size()
        let titleStringRect = CGRect(x: 20, y: textTop, width: pageRect.width - 20, height: titleSize.height)
        attributedTitle.draw(in: titleStringRect)
        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    
    func addDisclaimer(pageRect: CGRect, textTop: CGFloat) {
        let titleFont = UIFont.systemFont(ofSize: 13.0)
        let titleAttributes: [NSAttributedString.Key: Any] =
        [NSAttributedString.Key.font: titleFont, NSAttributedString.Key.foregroundColor: UIColor.gray]
        let attributedTitle = NSAttributedString(string: NSLocalizedString("Ce document ne constitue PAS un diagnostic médical.", comment: ""), attributes: titleAttributes)
        let titleSize = attributedTitle.size()
        let titleStringRect = CGRect(x: 20, y: textTop, width: pageRect.width - 20, height: titleSize.height)
        attributedTitle.draw(in: titleStringRect)
    }
}
