//
//  AudioPlayerManager.swift
//  CrazyPad
//
//  Created by francesco trotti on 04/12/24.
//
import Foundation
import AVFoundation

class AudioPlayerManager {
    /*static let shared = AudioPlayerManager()
    private var player: AVAudioPlayer?

    // Riproduci il file audio
    func playSound(named fileName: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "wav") else {
            print("File \(fileName) non trovato.")
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Errore nella riproduzione del file \(fileName): \(error)")
        }
    }*/
    
    

    
    static let shared = AudioPlayerManager()
        
        // Array per memorizzare tutti i player attivi
        private var activePlayers: [UUID: AVAudioPlayer] = [:]

        // Funzione per avviare o fermare un suono specifico
        
        func toggleSound(for sound: inout Sound) {
            if let player = sound.audioPlayer, player.isPlaying {
                // Se il suono è già in riproduzione, fermalo
                player.stop()
                activePlayers[sound.id] = nil  // Rimuovi dal dizionario dei player attivi
                sound.audioPlayer = nil        // Resetta il player per il suono
            } else {
                // Se il suono non è in riproduzione, riproducilo
                guard let url = Bundle.main.url(forResource: sound.fileName, withExtension: "wav") else {
                    print("File \(sound.fileName) non trovato.")
                    return
                }
                do {
                    sound.audioPlayer = try AVAudioPlayer(contentsOf: url)
                    if (sound.loop){
                        sound.audioPlayer?.numberOfLoops = -1
                    }
                    //sound.audioPlayer?.play()
                    BPMManager.shared.enqueueSound(sound)
                    activePlayers[sound.id] = sound.audioPlayer  // Aggiungi il player all'array dei player attivi
                } catch {
                    print("Errore nella riproduzione del file \(sound.fileName): \(error)")
                }
            }
        }
    
    

    

        // Funzione per fermare tutti i suoni
        func stopAllSounds() {
            for player in activePlayers.values {
                player.stop()  // Ferma ogni player
            }
            activePlayers.removeAll()  // Pulisce l'array dei player attivi
        }
    
    func play(_ sound:Sound){
        sound.audioPlayer?.play()
        
    }
    

}
