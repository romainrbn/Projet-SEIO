//
//  Projet_SEIOApp.swift
//  Projet_SEIO
//
//  Created by Romain Rabouan on 09/04/2021.
//

import SwiftUI

@main
struct Projet_SEIOApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
