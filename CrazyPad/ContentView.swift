//
//  ContentView.swift
//  CrazyPad
//
//  Created by francesco trotti on 04/12/24.
//

import SwiftUI


struct ContentView: View {
    let soundpacks: [Soundpack] = loadSoundpacks()
    /*let soundpacks: [Soundpack] = [
            Soundpack(
                title: "Hip-Hop Beats ",
                previewURL: nil,
                backgroundImage: Image("background"),
                backgroundColor: .blue,
                sounds: [
                    Sound(name: "Kick", type: "Bass", color: .red,fileName:"soundpacks/soundpack2/sound2"),
                    Sound(name: "Snare", type: "Percussion", color: .green,fileName:"soundpacks/soundpack2/sound3"),
                    Sound(name: "Synth", type: "Melody", color: .purple,fileName:"soundpacks/soundpack2/@TIDAL355 - Bentayga Cruisin [140bpm] F#m")
                    
                ]
            ),
            Soundpack(
                title: "Electronic Grooves",
                previewURL: nil,
                backgroundImage: nil,
                backgroundColor: .gray,
                sounds: [
                    Sound(name: "Bassline", type: "Bass", color: .yellow,fileName:"soundpacks/soundpack1/sound1.wav"),
                    Sound(name: "Hi-Hat", type: "Percussion", color: .orange,fileName:"soundpacks/soundpack1/sound1.wav"),
                    Sound(name: "Pad", type: "Melody", color: .cyan,fileName:"soundpacks/soundpack1/sound1.wav")
                ]
            )
        ]*/
        
        var body: some View {
            NavigationStack {
                SoundpackListView(soundpacks: soundpacks)
            }
            
        }
    
}

#Preview {
    ContentView()
}
