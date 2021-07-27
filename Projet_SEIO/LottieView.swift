//  LottieView.swift
//  Projet_Genou
//
//  Created by Romain Rabouan on 25/10/2020.

import SwiftUI
import Lottie

/**
 This view loads a Lottie View, and loops it.
 By default, it sets its background behavior to .pauseAndRestore
 - Parameter filename: The name of the JSON file that Lottie loads.
 - Parameter animationSpeed: The speed of the animation. 1 if left nil.
 */
#if os(iOS)
struct LottieView: UIViewRepresentable {

    var filename: String
    var animationSpeed: CGFloat = 1

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)

        let animationView = AnimationView()
        let animation = Animation.named(filename)
        animationView.animation = animation
        animationView.animationSpeed = animationSpeed
        animationView.loopMode = .loop

        animationView.contentMode = .scaleAspectFit
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.play()

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
#endif
