//
//  LottieView.swift
//  CrazyPad
//
//  Created by francesco trotti on 05/12/24.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    let animationName: String
    @Binding var isPlaying: Bool
    
    var loopMode: LottieLoopMode = .loop

    private let animationView = LottieAnimationView()

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        animationView.animation = LottieAnimation.named(animationName)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        

        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animationView.topAnchor.constraint(equalTo: view.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
            if isPlaying {
                animationView.play()
            } else {
                animationView.stop()
            }
        }
    
    func play() {
        self.animationView.play()
    }
    
    func stop(){
        self.animationView.stop()
    }
    
    func isPlayingMethod()->Bool{
        return self.animationView.isAnimationPlaying
    }
}

