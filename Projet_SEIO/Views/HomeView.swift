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
    
    var body: some View {
        NavigationView {
            emptyViewContent
                .navigationTitle("Accueil")
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
                .buttonStyle(ColoredButtonStyle(color: .blue))
                .padding(.top, 25)
                
            }.padding(.vertical)
            .alert(isPresented: $showAlert, content: {
                Alert(
                    title: Text("Information"),
                    message: Text("En continuant, vous vous engagez à tenir le rôle de médecin."),
                    primaryButton: .default(Text("Continuer"), action: {
                    self.showDiagnosticSheet.toggle()
                }), secondaryButton: .cancel()
                )
            })
            .sheet(isPresented: $showDiagnosticSheet, content: {
                DiagnosticView(showFlag: $showDiagnosticSheet)
        })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
