//
//  SoundPackBoxView.swift
//  CrazyPad
//
//  Created by francesco trotti on 04/12/24.
//

import SwiftUI
import AVFoundation
/*
struct SoundpackBoxView: View {
    let soundpack: Soundpack
    
    var body: some View {
        VStack(spacing: 8) { // VStack per includere il box e il titolo separatamente
            ZStack {
                // Sfondo del box
                if let image = soundpack.backgroundImage {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 150)
                        .clipped()
                } else {
                    soundpack.backgroundColor
                        .frame(height: 150)
                }
                
                // Pulsante Play
                VStack {
                    Spacer()
                    HStack {
                        Button(action: {
                            // Gestisci la preview del soundpack
                            playPreview(url: soundpack.previewURL)
                        }) {
                            Image(systemName: "play.circle.fill")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(8)
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        Spacer()
                    }
                    .padding()
                }
            }
            .frame(height: 150) // Altezza del box
            .cornerRadius(10)
            
            // Titolo del soundpack
            Text(soundpack.title)
                .font(.headline)
                .foregroundColor(.white)
                .padding(8)
                .frame(maxWidth: .infinity)
                .background(Color.black.opacity(0.7))
                .cornerRadius(5)
        }
    }


    
    func playPreview(url: URL?) {
        guard let url = url else { return }
        let player = AVPlayer(url: url)
        player.play()
    }
}
*/

/*struct SoundpackBoxView: View {
    let soundpack: Soundpack
    
    var body: some View {
        ZStack {
            // Sfondo del box
            if let image = soundpack.backgroundImage {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 150)
                    .clipped()
            } else {
                soundpack.backgroundColor
                    .frame(height: 150)
            }
            
            // Contenuto della box
            VStack {
                // Pulsante in alto a sinistra
                HStack {
                    Button(action: {
                        // Gestisci la preview del soundpack
                        playPreview(url: soundpack.previewURL)
                    }) {
                        Image(systemName: "play.circle.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                Spacer()
                // Titolo in basso
                Text(soundpack.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(5)
            }
            .padding(8) // Spazio interno alla box
        }
        .frame(height: 150) // Altezza del box
        .cornerRadius(10)
    }
    
    func playPreview(url: URL?) {
        guard let url = url else { return }
        let player = AVPlayer(url: url)
        player.play()
    }
}*/

import SwiftUI
import AVFoundation

struct SoundpackBoxView: View {
    let soundpack: Soundpack
    
    @State private var player: AVAudioPlayer? = nil
    @State private var isPlayingPreview: Bool = false

    var body: some View {
        ZStack {
            // Sfondo del box
            if let image = soundpack.backgroundImage {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 150)
                    .clipped()
            } else {
                soundpack.backgroundColor
                    .frame(height: 150)
            }
            
            // Contenuto della box
            VStack {
                // Pulsante in alto a sinistra
                HStack {
                    Button(action: {
                        // Gestisci la preview del soundpack
                        togglePreview()
                    }) {
                        Image(systemName: isPlayingPreview ? "stop.circle.fill" : "play.circle.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                    .accessibilityLabel("soundpack preview button")
                    .accessibilityHint("listen to the preview of the soundpack")
                    Spacer()
                }
                Spacer()
                // Titolo in basso
                Text(soundpack.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(5)
            }
            .padding(8) // Spazio interno alla box
        }
        .frame(height: 150) // Altezza del box
        .cornerRadius(10)
        .onAppear {
            setupPlayer()
        }
    }
    
    func setupPlayer() {
        guard let previewURL = soundpack.previewURL else {
            print("URL di anteprima non disponibile per il soundpack: \(soundpack.title)")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: previewURL)
            player?.prepareToPlay()
        } catch {
            print("Errore durante l'inizializzazione di AVAudioPlayer: \(error)")
        }
    }
    
    func togglePreview() {
        guard let player = player else { return }
        
        if isPlayingPreview {
            player.stop()
        } else {
            player.play()
        }
        
        isPlayingPreview.toggle()
    }
}


