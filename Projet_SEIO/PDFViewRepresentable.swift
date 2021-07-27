//
//  PDFViewRepresentable.swift
//  Projet_SEIO
//
//  Created by Romain Rabouan on 23/06/2021.
//

import SwiftUI
import PDFKit
import UIKit

struct PDFViewRepresentable: UIViewRepresentable {
    
    let data: Data
    init(_ data: Data) {
        self.data = data
    }
    
    func makeUIView(context: Context) -> some UIView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.document = PDFDocument(data: data)
        return pdfView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
