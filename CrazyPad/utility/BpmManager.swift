//
//  BpmManager.swift
//  CrazyPad
//
//  Created by francesco trotti on 04/12/24.
//

import Foundation


class BPMManager {
    static let shared = BPMManager()
    
    private var timer: DispatchSourceTimer?
    private var bpm: Double = 120.0 // Default BPM
    private var queue: [Sound] = [] // Coda di suoni da riprodurre al prossimo beat
   
    
    // Calcola il periodo di un beat in secondi
    private var beatInterval: TimeInterval {
        return 60.0 / bpm
    }
    
    // Inizia il timer BPM
    func startBPM(_ bpm: Double) {
        self.bpm = bpm
        stopBPM() // Ferma eventuali timer esistenti
        
        let timer = DispatchSource.makeTimerSource()
        timer.schedule(deadline: .now(), repeating: beatInterval)
        timer.setEventHandler { [weak self] in
            self?.handleBeat()
            print(self?.queue)
        }
        self.timer = timer
        timer.resume()
    }
    
    // Ferma il timer BPM
    func stopBPM() {
        timer?.cancel()
        timer = nil
    }
    
    // Aggiunge un suono alla coda per il prossimo beat
    func enqueueSound(_ sound: Sound) {
        queue.append(sound)
    }
    
    // Gestisce l'evento di un beat
    private func handleBeat() {
        let soundsToPlay = self.queue
        queue.removeAll() // Svuota la coda
        
        print(soundsToPlay)
        
        for sound in soundsToPlay {
            AudioPlayerManager.shared.play(sound)
        }
        
      
    }
    
    
    
    
    
}
