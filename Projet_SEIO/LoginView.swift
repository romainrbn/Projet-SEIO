//
//  LoginView.swift
//  Projet_SEIO
//
//  Created by Romain Rabouan on 13/05/2021.
//

import SwiftUI

struct LoginView: View {
    @State private var showDiagnosticView = false
    @State private var showAlert = false
    @State private var showFlag = false
    @State private var activateLink = false
    @AppStorage("hasShownOnboarding") var hasShownOnboarding = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image("logo_sfa")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .padding(.top)
                
                Spacer()
                
                
                Text("Cette application (réservée aux professionnels de santé) vous permet d'effectuer un interrogatoire concernant l'état du genou d'un patient. À la fin de ces questions, un score est attribué permettant d'évaluer l'action à prendre.")
                    .font(.callout)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                Spacer()
                
                Button("Continuer", action: {
                    self.showAlert.toggle()
                })
                .buttonStyle(ColoredButtonStyle(color: .accentColor))
            }
            .padding()
            .navigationTitle("Bienvenue !")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .alert(isPresented: $showAlert, content: {
            
            Alert(
                title: Text("Information"),
                message: Text("En continuant, vous vous engagez à tenir le rôle de médecin."),
                primaryButton: .default(Text("Continuer"), action: {
                DispatchQueue.main.async {
                    self.hasShownOnboarding = true
                    self.showDiagnosticView.toggle()
                }
            }), secondaryButton: .cancel(Text("Annuler"))
            )
        })
        .fullScreenCover(isPresented: $showDiagnosticView) {
            HomeView(showFlag: $showFlag, dismissFlag: $showDiagnosticView)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
