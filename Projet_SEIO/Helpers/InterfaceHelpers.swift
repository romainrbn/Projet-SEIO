//
//  InterfaceHelpers.swift
//  Projet_SEIO
//
//  Created by Romain Rabouan on 09/04/2021.
//

import SwiftUI

/**
 Créé un bouton au style iOS avec une couleur personnalisable.
 */
struct ColoredButtonStyle: ButtonStyle {
    let color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 17, weight: .regular))
            .minimumScaleFactor(0.5)
            .lineLimit(1)
            .multilineTextAlignment(.center)
            .padding(.vertical, 13)
            .padding(.horizontal, (UIScreen.main.bounds.width / 2) - 110)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .foregroundColor(.white)
            .overlay(
                Color.black.opacity(configuration.isPressed ? 0.3 : 0)
                    .clipShape(RoundedRectangle(cornerRadius: 13))
            )

    }
}

/**
 Créé un style de bouton avec un coutour et un background optionnel dans le cas où le bouton est sélectionné.
*/
struct OutlinedButtonStyle: ButtonStyle {
    let color: Color
    var shouldHaveBackgroundEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 17, weight: .regular))
            .minimumScaleFactor(0.5)
            .lineLimit(3)
            .multilineTextAlignment(.center)
            .padding(.vertical, 13)
            .padding(.horizontal, (UIScreen.main.bounds.width / 2) - 110)
            .background(shouldHaveBackgroundEnabled ? color : Color.white.opacity(0.001))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .foregroundColor(shouldHaveBackgroundEnabled ? .white : color)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                                .stroke(color, lineWidth: 2)
            )
            .overlay(
                Color.black.opacity(configuration.isPressed ? 0.2 : 0)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            )
    }
}
