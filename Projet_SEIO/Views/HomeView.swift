//
//  ContentView.swift
//  Projet_SEIO
//
//  Created by Romain Rabouan on 09/04/2021.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    static let homeViewTag: String? = "HomeView"
    
    @State private var showDiagnosticSheet = false
    @State private var showAlert = false
    
    @Binding var showFlag: Bool
    @Binding var dismissFlag: Bool
    @State var rpps: String
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            emptyViewContent
                .navigationTitle("Accueil")
                .navigationBarItems(trailing: Button("Déconnexion", action: {
                    self.dismissFlag.toggle()
                })
            )
        }
    }
    
    private var emptyViewContent: some View {
        ScrollView(.vertical) {
            VStack {
                Image("logo_sfa")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .padding(.bottom, 20)
                
                Image("doctor_illustration")
                    .resizable()
                    .imageScale(.large)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 220, height: 220)
                    .padding(.bottom, 20)
                            
                Text("Appuyez sur le bouton ci-dessous pour commencer un diagnostic")
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .padding()
                
                Text("Les données ne sont jamais sauvegardées, ni sur l'appareil, ni sur un serveur. Vous pourrez envoyer le diagnostic par courriel lors du résultat.")
                    .multilineTextAlignment(.center)
                    .font(.caption)
                    .padding()
                
                Button("Nouveau diagnostic") {
                    // Affiche une alerte de confirmation
                    self.showAlert.toggle()
                }
                .buttonStyle(ColoredButtonStyle(color: .accentColor))
                .padding(.top, 25)
                
            }.padding(.vertical)
            .alert(isPresented: $showAlert, content: {
                Alert(
                    title: Text("Information"),
                    message: Text("En continuant, vous vous engagez à tenir le rôle de médecin."),
                    primaryButton: .default(Text("Continuer"), action: {
                    self.showDiagnosticSheet.toggle()
                }), secondaryButton: .cancel(Text("Annuler"))
                )
            })
            .fullScreenCover(isPresented: $showDiagnosticSheet, content: {
                QuestionnaireView(showFlag: $showDiagnosticSheet)
            })
        }
    }
}
