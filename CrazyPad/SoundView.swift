//
//  SoundView.swift
//  CrazyPad
//
//  Created by francesco trotti on 04/12/24.
//


import SwiftUI

struct SoundView: View {
    @State var sound: Sound
    let onButtonPressed: (Int) -> Void
       @State private var isPlaying: Bool = false
       @State private var activeDots: [Bool] = []
       let totalDots: Int = 12 // Numero totale di punti nel cerchio

       var body: some View {
           Button(action: {
               // Riproduci il suono associato
               //AudioPlayerManager.shared.playSound(named: sound.fileName)
               AudioPlayerManager.shared.toggleSound(for:&sound)
               
               isPlaying.toggle()
               if isPlaying {
                   startAnimation()
                   onButtonPressed(1)
                  
               } else {
                   stopAnimation()
                   onButtonPressed(-1)

               }
           }) {
               VStack {
                   // Cerchio tratteggiato con animazione sui punti
                   ZStack {
                       ForEach(0..<totalDots, id: \.self) { index in
                           Circle()
                               .frame(width: 6, height: 6)
                               .offset(x: 25)
                               .rotationEffect(.degrees(Double(index) / Double(totalDots) * 360))
                               .foregroundColor(activeDots.indices.contains(index) && activeDots[index] ? .white : .gray)
                               .animation(.easeInOut(duration: 0.1), value: activeDots)
                       }
                   }
                   .frame(width: 60, height: 60)
                   
                   VStack(alignment: .leading) {
                       Text(sound.name)
                           .font(.subheadline)
                           .foregroundColor(.white)
                       Text(sound.type)
                           .font(.caption)
                           .foregroundColor(.white.opacity(0.7))
                   }
               }
               .frame(maxWidth: .infinity, minHeight: 100)
               .padding()
               .background(sound.color)
               .cornerRadius(10)
           }
           .onAppear {
               activeDots = Array(repeating: false, count: totalDots)
           }
       }
       
       private func startAnimation() {
           resetDots()
           Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
               if !isPlaying {
                   timer.invalidate()
               } else {
                   updateDots()
               }
           }
       }
       
       private func stopAnimation() {
           resetDots()
       }
       
       private func resetDots() {
           activeDots = Array(repeating: false, count: totalDots)
       }
       
       private func updateDots() {
           if let nextIndex = activeDots.firstIndex(of: false) {
               activeDots[nextIndex] = true
           } else {
               resetDots()
           }
       }
        
       
}

