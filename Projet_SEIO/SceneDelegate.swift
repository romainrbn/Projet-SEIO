//
//  SceneDelegate.swift
//  ProjetSEIO
//
//  Created by Romain Rabouan on 20/04/2021.
//

import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let isLoggedIn = UserDefaults.standard.bool(forKey: "loggedIn")
        
        if isLoggedIn {
            let mainView = HomeView(showFlag: .constant(false), dismissFlag: .constant(false))
            if let windowScene = scene as? UIWindowScene {
                let window = UIWindow(windowScene: windowScene)
                window.rootViewController = UIHostingController(rootView: mainView)
                self.window = window
                window.makeKeyAndVisible()
            }
        } else {
            let loginView = LoginView()
            if let windowScene = scene as? UIWindowScene {
                let window = UIWindow(windowScene: windowScene)
                window.rootViewController = UIHostingController(rootView: loginView)
                self.window = window
                window.makeKeyAndVisible()
            }
        }
    }
}

