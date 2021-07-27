//
//  QuizReponseView.swift
//  Projet_SEIO
//
//  Created by Romain Rabouan on 08/06/2021.
//

import SwiftUI

struct QuizReponseView: View {
    var title: String
    @Binding var selected: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .multilineTextAlignment(.leading)
            Spacer()
            
            Image(systemName: "chevron.forward")
        }
        .padding([.horizontal])
        .padding(.vertical, 12)
        
        .foregroundColor(selected ? .white : Color("BackgroundPlainInverted"))
    }
}
