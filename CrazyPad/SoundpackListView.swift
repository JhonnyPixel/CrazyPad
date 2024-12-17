//
//  SoundpackListView.swift
//  CrazyPad
//
//  Created by francesco trotti on 04/12/24.
//

import SwiftUI

struct SoundpackListView: View {
    let soundpacks: [Soundpack]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                ForEach(soundpacks) { soundpack in
                    NavigationLink(destination: LaunchpadView(soundpack: soundpack)) {
                        SoundpackBoxView(soundpack: soundpack)
                            
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Soundpacks")
    }
}
