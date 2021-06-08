//
//  ResultView.swift
//  Projet_SEIO
//
//  Created by Romain Rabouan on 13/05/2021.
//

import SwiftUI

struct ResultView: View {
    @State var score: Int
    @State private var patientName: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Quizz terminé !")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Score final :")
                .font(.title2)
                .fontWeight(.medium)
            
            Text("\(score)")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .frame(width: 70, height: 70, alignment: .center)
                .foregroundColor(.white)
                .background(determineColor(from: score))
                .clipShape(Circle())
                .padding()
            
            Text("DIAG_TEXTE_MEDECIN (à venir éventuellement)") // texte de diagnostic, à venir.
            
            Text("Vous pouvez renseigner le nom du patient qui sera inscrit sur le fichier de diagnostic que vous pourrez envoyer par courriel.")
                .font(.caption)
                .multilineTextAlignment(.center)
                .padding(.top)
            
            TextField("Nom du patient", text: $patientName)
                .autocapitalization(.words)
                .disableAutocorrection(true)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.vertical)
            
            Spacer()
            
            Button("Générer le diagnostic", action: {
                print("Générer le diagnostic")
            })
            .buttonStyle(ColoredButtonStyle(color: patientName == "" ? .gray : .blue))
            .disabled(patientName == "")
            
        }.padding()
    }
    
    func determineColor(from score: Int) -> Color { // À changer selon les directives médecins
        if score < 4 {
            return .green
        } else if score >= 4 && score < 8 {
            return .orange
        } else if score >= 8 {
            return .red
        } else {
            return .gray // en cas d'erreur
        }
    }
}
