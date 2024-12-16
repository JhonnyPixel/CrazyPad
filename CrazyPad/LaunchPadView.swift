//
//  LaunchPad.swift
//  CrazyPad
//
//  Created by francesco trotti on 04/12/24.
//

import SwiftUI
import AVFoundation
import Lottie

/*struct LaunchpadView: View {
    
    let soundpack: Soundpack
    
    let columns = [GridItem(.adaptive(minimum: 100))]
    
    @State var activeSounds:Int = 0

    
    var body: some View {
        
        let animationView=LottieView(animationName: "soundAnimation")
        
        if(activeSounds>0 && animationView.isPlaying()){
            animationView.play()
        }else{
            animationView.stop()
        }
        
        
        
        
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(soundpack.sounds) { sound in
                    SoundView(sound: sound,onButtonPressed:{value in
                        updateActiveSounds(value)
                    })
                }
            }
            .padding()
        }
        .navigationTitle(soundpack.title)
        .onAppear{
                        // Avvia il BPM quando la view appare
            BPMManager.shared.startBPM(soundpack.bpm)
           
        }
        .onDisappear {
                        // Ferma il BPM quando la view scompare (opzionale)
            BPMManager.shared.stopBPM()
            AudioPlayerManager.shared.stopAllSounds()
        }
        
    }
    
    func updateActiveSounds(_ x:Int){
        activeSounds+=x;
    }
        
    
}*/

struct LaunchpadView: View {
    let soundpack: Soundpack
    
    let columns = [GridItem(.adaptive(minimum: 100))]
    @State var activeSounds: Int = 0
    @State private var isAnimationPlaying: Bool = false

    var body: some View {
        VStack {
            // Lottie Animation View
            LottieView(animationName: "musicAnimation", isPlaying: $isAnimationPlaying)
                .frame(height: 200)
            
            // Grid di suoni
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(soundpack.sounds) { sound in
                        SoundView(sound: sound, onButtonPressed: { value in
                            updateActiveSounds(value)
                        })
                    }
                }
                .padding()
            }
        }
        .navigationTitle(soundpack.title)
        .onAppear {
            // Avvia il BPM quando la view appare
            BPMManager.shared.startBPM(soundpack.bpm)
        }
        .onDisappear {
            // Ferma il BPM quando la view scompare (opzionale)
            BPMManager.shared.stopBPM()
            AudioPlayerManager.shared.stopAllSounds()
        }
    }

    func updateActiveSounds(_ x: Int) {
        activeSounds += x
        // Controlla se l'animazione deve essere avviata o fermata
        isAnimationPlaying = activeSounds > 0
    }
}

