//
//  UserPasswordInfos.swift
//  Projet_SEIO
//
//  Created by Romain Rabouan on 16/07/2021.
//

import SwiftUI
import MessageUI

struct UserPasswordInfos: View {
    
    @State private var showShareSheet = false
    
    var patientName: String
    var patientFirstName: String
    var patientBirthYear: String
    var doctorEmail: String
    var doctorPassword: String
    var pdfCreator: PDFCreator
    
    @State var result: Result<MFMailComposeResult, Error>? = nil
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 20) {
                HStack {
                    Spacer()
                    Text("Mot de passe pour le patient")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                                
                Text("Le mot de passe que devra entrer le patient pour ouvrir ce document sera son prénom, suivi de la première lettre de son nom de famille puis son année de naissance, en minuscules.")
                    .multilineTextAlignment(.center)
                    .lineLimit(4)
                
                Text("Par exemple, pour 'Jean Dupont' né en 1967, le mot de passe serait 'jeand1967'.")
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .foregroundColor(.secondary)
                    .padding(.bottom)
                
                Spacer()
                
                Button(action: {
                    self.showShareSheet.toggle()
                }) {
                    Text("Envoyer le document")
                        .fontWeight(.bold)
                }
                
                
            }.padding()
            
                .sheet(isPresented: $showShareSheet) {
                    MailView(isShowing: $showShareSheet, result: $result, patientName: patientName, doctorEmail: doctorEmail, pdfData: pdfCreator.createPage(with: doctorPassword, userPassword: generateUserPassword()))
                }
            
        }
        .navigationBarItems(trailing: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("Terminé")
        })
    }
    
    func showPassword() {
        let firstName = patientFirstName.lowercased().trimmingCharacters(in: .whitespaces).replacingOccurrences(of: " ", with: "")
        let lastName = patientName.lowercased().trimmingCharacters(in: .whitespaces).prefix(1)
        let birthYear = patientBirthYear
        let pass = "\(firstName)\(lastName)\(birthYear)"
        print("PASS: \(pass)")
    }
    
    func generateUserPassword() -> String {
        let firstName = patientFirstName.lowercased().trimmingCharacters(in: .whitespaces).replacingOccurrences(of: " ", with: "")
        let lastName = patientName.lowercased().trimmingCharacters(in: .whitespaces).prefix(1)
        let birthYear = patientBirthYear
        let pass = "\(firstName)\(lastName)\(birthYear)"
        print("PASS: \(pass)")
        return pass
    }
}
