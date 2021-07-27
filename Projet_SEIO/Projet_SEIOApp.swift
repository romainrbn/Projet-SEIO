//
//  Projet_SEIOApp.swift
//  Projet_SEIO
//
//  Created by Romain Rabouan on 09/04/2021.
//

import SwiftUI

@main
struct Projet_SEIOApp: App {
    @AppStorage("hasShownOnboarding") var hasShownOnboarding = false

    var body: some Scene {
        WindowGroup {
            if hasShownOnboarding {
                HomeView(showFlag: .constant(false), dismissFlag: .constant(true))
            } else {
                LoginView()
            }
        }
    }
}
