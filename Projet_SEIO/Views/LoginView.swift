//
//  LoginView.swift
//  Projet_SEIO
//
//  Created by Romain Rabouan on 13/05/2021.
//

import SwiftUI

struct LoginView: View {
    @State private var showHomeView = false
    @State private var showDiagnosticView = false
    @State private var rppsText = ""
    var body: some View {
        NavigationView {
            VStack {
                
                Spacer()
                
                Image("logo_sfa")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .padding(.top)
                
                Spacer()
                
                Text("Pour commencer, veuillez entrer votre numéro RPPS.\nCe numéro n'est stocké sur votre appareil que durant votre session puis est effacé. Il ne sort jamais de votre appareil.\nEn continuant, vous vous engagez à être un professionnel de santé habilité.")
                    .font(.caption)
                    .multilineTextAlignment(.leading)
                
                TextField("Numéro RRPS", text: $rppsText)
                    .autocapitalization(.allCharacters)
                    .disableAutocorrection(true)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical)
                
                Spacer()
                Spacer()
                
                Button("Connexion", action: {
                    print("Connect...")
                    self.showHomeView.toggle()
                    rppsText = "" // efface les données RPPS
                })
                .buttonStyle(ColoredButtonStyle(color: .accentColor))
            }
            .padding()
            .navigationTitle("Bienvenue !")
        }
        .fullScreenCover(isPresented: $showHomeView) {
            HomeView(showFlag: $showDiagnosticView, dismissFlag: $showHomeView, rpps: rppsText)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
