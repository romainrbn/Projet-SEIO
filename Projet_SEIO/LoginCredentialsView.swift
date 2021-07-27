//
//  LoginCredentialsView.swift
//  Projet_SEIO
//
//  Created by Romain Rabouan on 16/06/2021.
//

import SwiftUI

struct LoginCredentialsView: View {
    @AppStorage("userEmail") var userEmail = ""
    @AppStorage("loggedIn") var loggedIn = false
    @State private var rememberEmail = false
    @State private var showHomeScreen = false
    @State var showFlag = false
    @State var canShow = false
    
    var body: some View {
        VStack {
            Text("Si vous le souhaitez, vous pouvez renseigner votre adresse email. Cette dernière reste sur votre appareil et sera inscrite sur le document PDF qui sera généré à la fin de l'interrogatoire. Vous pourrez envoyer ce document par courriel.")
                .multilineTextAlignment(.leading)
            
            Spacer()
            Spacer()
            
            VStack(spacing: 16) {
                TextField("Adresse email", text: $userEmail)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Toggle(isOn: $rememberEmail) {
                    Text("Se souvenir de moi")
                }
                .disabled(userEmail == "")
                
                Text("Si vous activez l'option 'Se souvenir de moi', vous n'aurez pas à entrer votre adresse email lors de chaque utilisation de l'application.")
                    .font(.caption)
                    .multilineTextAlignment(.leading)
                    .padding(.vertical)
            }
            
            
            Spacer()
            Spacer()
            
            Button("Continuer", action: {
                if(rememberEmail) {
                    loggedIn = true
                } else {
                    userEmail = ""
                }
                self.canShow.toggle()
            })
            .buttonStyle(ColoredButtonStyle(color: .accentColor))
            .disabled(userEmail == "")
            
            Button("Continuer sans adresse email", action: {
                self.canShow.toggle()
            })
                .padding(.vertical)
            
            
        }.padding()
        .fullScreenCover(isPresented: $canShow) {
            HomeView(showFlag: $showFlag, dismissFlag: $showHomeScreen)
        }
    }
}
