//
//  MoreInfoView.swift
//  Projet_SEIO
//
//  Created by Romain Rabouan on 23/06/2021.
//

import SwiftUI

struct MoreInfoView: View {
    @Binding var showFlag: Bool
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
            }
            .padding()
            .navigationTitle("Informations")
            .navigationBarItems(trailing: Button(action: {
                self.showFlag.toggle()
            }) {
                Text("Terminé")
            })
        }
        
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
