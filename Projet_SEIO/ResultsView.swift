//
//  ResultsView.swift
//  Projet_SEIO
//
//  Created by Romain Rabouan on 10/06/2021.
//

import SwiftUI
import UIKit
import MessageUI

struct ResultsView: View {
    @State var score: Int
    @State private var patientName: String = ""
    @State private var patientBirthYear: String = ""
    @State private var patientFirstName: String = ""
    @State private var showAlert = false
    @State private var showPDF = false
    @Binding var showFlag: Bool
    @AppStorage("doctorEmail") var doctorEmail: String = ""
    @AppStorage("rememberMe") var rememberMe = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                LazyVStack {
                    Text("Diagnostic terminé !")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                        .padding(.top)
                        
                    
                    Text("Score final :")
                        .font(.title2)
                        .fontWeight(.medium)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    
                    Text("\(score)")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .frame(width: 70, height: 70, alignment: .center)
                        .foregroundColor(.white)
                        .background(determineColor(from: score))
                        .clipShape(Circle())
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    
                    Text("Recommandations :")
                        .foregroundColor(.secondary)
                        .fontWeight(.semibold)
                        .font(.subheadline)
                    
                    Label(LocalizedStringKey(determineRecommendationForScore(score: score)), systemImage: determineImageNameForRecommendation(score: score))
                        .multilineTextAlignment(.center)
                        .padding(.vertical)
                        .accentColor(determineColor(from: score))
                    
                }
                
                Section(footer: Text("Vous pouvez renseigner ces informations qui seront inscrites sur le fichier de résultat que vous pouvez envoyer par courriel. Les données sont supprimées après l'envoi et ne quittent pas votre appareil.")) {
                    TextField(LocalizedStringKey("Nom du patient"), text: $patientName)
                        .autocapitalization(.words)
                        .disableAutocorrection(true)
                    
                    TextField(LocalizedStringKey("Prénom du patient"), text: $patientFirstName)
                        .autocapitalization(.words)
                        .disableAutocorrection(true)
                    
                    
                
                TextField(LocalizedStringKey("Année de naissance du patient"), text: $patientBirthYear)
                    .keyboardType(.numberPad)
                    
                    TextField(LocalizedStringKey("Adresse email du médecin"), text: $doctorEmail)
                        .keyboardType(.emailAddress)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                
                Section(footer: Text("Vous pouvez choisir d'enregistrer l'adresse email sur votre appareil pour éviter de devoir la renseigner à chaque test.")) {
                    Toggle(isOn: $rememberMe) {
                        Text("Se souvenir de mon adresse email")
                    }
                    .disabled(doctorEmail == "")
                }
                
                Button("Visualiser le résultat PDF", action: {
                    if(doctorEmail == "" || patientName == "" || patientBirthYear == "" || patientFirstName == "") {
                        self.showAlert.toggle()
                    } else {
                        // Générer le PDF
                        generateEncryptedPDFResult()
                    }
                })
                .foregroundColor(.blue)
                
                NavigationLink("Envoyer le résultat PDF",
                               destination: SendPDFView(
                                pdfCreator: PDFCreator(title: "Résultat du test",
                                                    patientName: "\(patientFirstName) \(patientName)",
                                                    image: UIImage(named: "logo_sfa")!,
                                                    practicienEmail: doctorEmail,
                                                    finalScoreString: "Score final :",
                                                    finalScoreResult: "\(score)"),
                                patientName: patientName,
                                patientFirstName: patientFirstName,
                                patientBirthYear: patientBirthYear,
                                doctorEmail: doctorEmail
                               )
                )
                    .disabled(doctorEmail == "" || patientName == "")
                    .foregroundColor(.blue)
            }
            .navigationBarItems(trailing: Button(action: {
                self.showFlag.toggle()
            }) { Text("Terminé").foregroundColor(.blue) })
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Erreur"), message: Text("Veuillez remplir tous les champs pour générer le PDF de résultat."), dismissButton: .default(Text("OK")))
        }
        .sheet(isPresented: $showPDF) {
            PDFPreview(pdfCreator: PDFCreator(title: NSLocalizedString("Résultat du test", comment: ""), patientName: "\(patientFirstName) \(patientName)", image: UIImage(named: "logo_sfa")!, practicienEmail: doctorEmail, finalScoreString: "Score final :", finalScoreResult: "\(score)"), dismissFlag: $showPDF)
        }
    }
    
    func generateEncryptedPDFResult() {
        self.showPDF.toggle()
    }
    
    func sendEncryptedPDFResult() {
        print("Send encypted pdf")
    }
    
    func determineColor(from score: Int) -> Color { // À changer selon les directives médecins
        if score <= 4 {
            return .green
        } else if score > 4 && score < 8 {
            return .orange
        } else if score >= 8 {
            return .red
        } else {
            return .gray // en cas d'erreur
        }
    }
    
    func determineRecommendationForScore(score: Int) -> String {
        if score < 5 {
            return "Traumatisme mineur du genou. Rendez-vous chez le médecin généraliste conseilé. Pas d'IRM en principe."
        } else if score >= 5 && score < 8 {
            return "Traumatisme modéré du genou. IRM sans urgence (2 mois), rendez-vous avec un médecin du sport ou un chirurgien orthopédiste conseillé."
        } else if score >= 8 {
            return "Traumatisme grave du genou. Un rendez-vous IRM rapide est conseillé si possible, suivi d'un RDV chez un chirurgien orthopédiste."
        }
        
        return "Error: Score out of bounds."
    }
    
    func determineImageNameForRecommendation(score: Int) -> String {
        if score < 5 {
            return "checkmark.circle.fill"
        } else if score >= 5 && score < 8 {
            return "exclamationmark.triangle.fill"
        } else if score >= 8 {
            return "exclamationmark.square.fill"
        }
        
        return "questionmark.circle.fill"
    }
}

struct SendPDFView: View {
    var pdfCreator: PDFCreator
    var patientName: String
    var patientFirstName: String
    var patientBirthYear: String
    var doctorEmail: String
    @State private var documentPassword = ""
    @State private var repeatPassword = ""
    @State private var showPassword = false
    @State private var showShareSheet = false
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Form {
            Section(footer: Text("Afin de sécuriser l'échange de données, un mot de passe est nécessaire. Il vous sera demandé pour ouvrir le document sur un autre appareil.")) {
                if showPassword {
                    TextField("Mot de passe du document", text: $documentPassword)
                    TextField("Confirmer le mot de passe", text: $repeatPassword)

                } else {
                    SecureField("Mot de passe du document", text: $documentPassword)
                    SecureField("Confirmer le mot de passe", text: $repeatPassword)
                }
            }
            
            Toggle(isOn: $showPassword) {
                Text("Afficher le mot de passe")
            }
            
            NavigationLink(destination: UserPasswordInfos(patientName: patientName, patientFirstName: patientFirstName, patientBirthYear: patientBirthYear, doctorEmail: doctorEmail, doctorPassword: documentPassword, pdfCreator: pdfCreator, result: result)) {
                Text("Suivant")
            }
            .foregroundColor(.accentColor)
            .disabled((documentPassword != repeatPassword) || documentPassword == "")
            .navigationTitle(Text("Envoyer le PDF"))
        }
        .navigationBarItems(trailing: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("Terminé")
        })
    }
}

struct PDFPreview: View {
    let pdfCreator: PDFCreator
    @Binding var dismissFlag: Bool
    var body: some View {
        NavigationView {
            PDFViewRepresentable(pdfCreator.createPage())
                .navigationTitle(Text("Aperçu"))
                .navigationBarItems(trailing: Button(action: {
                    self.dismissFlag.toggle()
                }) {
                    Text("Terminé")
                })
        }
    }
}

