//
//  SoundPackManager.swift
//  CrazyPad
//
//  Created by francesco trotti on 04/12/24.
//

import Foundation
import SwiftUI

// Funzione per caricare tutti i Soundpack dalla directory "Soundpacks"




/*func loadSoundpacks() -> [Soundpack] {
    var soundpacks: [Soundpack] = []
    let fileManager = FileManager.default
    
    // Percorso della cartella "soundpacks" nel bundle
    guard let soundpacksURL = Bundle.main.url(forResource: "soundpacks", withExtension: nil) else {
        print("La cartella soundpacks non è presente nel bundle.")
        return soundpacks
    }

    print("Percorso della cartella soundpacks: \(soundpacksURL)")

    do {
        // Ottieni tutte le sottocartelle (Soundpack) dentro soundpacks
        let subfolders = try fileManager.contentsOfDirectory(at: soundpacksURL, includingPropertiesForKeys: [.isDirectoryKey], options: .skipsHiddenFiles)

        for subfolderURL in subfolders {
            print("Trovata sottocartella: \(subfolderURL)")

            // Verifica che sia effettivamente una directory
            var isDirectory: ObjCBool = false
            if fileManager.fileExists(atPath: subfolderURL.path, isDirectory: &isDirectory), isDirectory.boolValue {

                // Leggi i file nella sottocartella
                let soundFiles = try fileManager.contentsOfDirectory(at: subfolderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)

                // Crea gli oggetti Sound
                var sounds: [Sound] = []
                for soundFile in soundFiles where soundFile.pathExtension == "wav" {
                    // Crea il percorso relativo partendo dalla cartella "soundpacks"
                    let relativePath = soundpacksURL.relativePath
                    let soundFilePath = soundFile.deletingPathExtension().relativePath.replacingOccurrences(of: relativePath, with: "soundpacks")
                    
                    print("Percorso relativo del file audio (senza estensione): \(soundFilePath)")

                    let soundName = soundFile.deletingPathExtension().lastPathComponent
                    let sound = Sound(
                        name: soundName,
                        type: determineSoundType(from: soundName), // Funzione per determinare il tipo
                        color: randomColor(), // Funzione per assegnare un colore casuale
                        fileName: soundFilePath // Usa il percorso relativo senza estensione
                    )
                    sounds.append(sound)
                }

                // Crea l'oggetto Soundpack
                let soundpack = Soundpack(
                    title: subfolderURL.lastPathComponent,
                    previewURL: nil, // Puoi impostarlo in base a un file di anteprima opzionale
                    backgroundImage: nil, // Puoi gestirlo in base ai tuoi asset
                    backgroundColor: randomColor(), // Colore casuale per ora
                    sounds: sounds
                )
                soundpacks.append(soundpack)
            }
        }
    } catch {
        print("Errore durante il caricamento dei Soundpack: \(error)")
    }

    return soundpacks
}*/

func loadSoundpacks() -> [Soundpack] {
    var soundpacks: [Soundpack] = []
    let fileManager = FileManager.default
    
    // Percorso della cartella "soundpacks" nel bundle
    guard let soundpacksURL = Bundle.main.url(forResource: "soundpacks", withExtension: nil) else {
        print("La cartella soundpacks non è presente nel bundle.")
        return soundpacks
    }

    print("Percorso della cartella soundpacks: \(soundpacksURL)")

    do {
        // Ottieni tutte le sottocartelle (Soundpack) dentro soundpacks
        let subfolders = try fileManager.contentsOfDirectory(at: soundpacksURL, includingPropertiesForKeys: [.isDirectoryKey], options: .skipsHiddenFiles)

        for subfolderURL in subfolders {
            print("Trovata sottocartella: \(subfolderURL)")

            // Verifica che sia effettivamente una directory
            var isDirectory: ObjCBool = false
            if fileManager.fileExists(atPath: subfolderURL.path, isDirectory: &isDirectory), isDirectory.boolValue {

                // Leggi i file nella sottocartella
                let soundFiles = try fileManager.contentsOfDirectory(at: subfolderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)

                // Variabili per immagine di background e anteprima
                var backgroundImage: Image? = nil
                var previewURL: URL? = nil
                var sounds: [Sound] = []

                // Processa i file nella sottocartella
                for soundFile in soundFiles {
                    if ["jpg", "jpeg", "png"].contains(soundFile.pathExtension.lowercased()) {
                        // File immagine per background
                        if let uiImage = UIImage(contentsOfFile: soundFile.path) {
                            backgroundImage = Image(uiImage: uiImage)
                            print("Immagine di background caricata: \(soundFile.lastPathComponent)")
                        } else {
                            print("Errore: impossibile caricare l'immagine da \(soundFile.path)")
                        }
                    } else if soundFile.lastPathComponent.lowercased().contains("preview") {
                        // File anteprima del soundpack
                        previewURL = soundFile
                        print("File di anteprima trovato: \(soundFile.lastPathComponent)")
                    } else if soundFile.pathExtension == "wav" {
                        // File audio
                        let relativePath = soundpacksURL.relativePath
                        let soundFilePath = soundFile.deletingPathExtension().relativePath.replacingOccurrences(of: relativePath, with: "soundpacks")
                        
                        let soundName = soundFile.deletingPathExtension().lastPathComponent
                        let soundType = determineSoundType(from: soundName)
                        let sound = Sound(
                            name: soundType,
                            type: soundType, // Funzione per determinare il tipo
                            color: determineColor(soundType), // Funzione per assegnare un colore casuale
                            fileName: soundFilePath // Usa il percorso relativo senza estensione
                        )
                        sounds.append(sound)
                    }
                }

                // Crea l'oggetto Soundpack
                let soundpack = Soundpack(
                    title: subfolderURL.lastPathComponent,
                    previewURL: previewURL, // File che contiene "preview"
                    backgroundImage: backgroundImage, // File immagine
                    backgroundColor: randomColor(), // Colore casuale per ora
                    sounds: sounds
                )
                soundpacks.append(soundpack)
            }
        }
    } catch {
        print("Errore durante il caricamento dei Soundpack: \(error)")
    }

    return soundpacks
}




// Funzione per determinare il tipo di suono (personalizzabile)
func determineSoundType(from name: String) -> String {
    if name.lowercased().contains("bass") {
        return "basso"
    } else if name.lowercased().contains("vocals") {
        return "vocals"
    } else if name.lowercased().contains("melody") {
        return "melody"
    } else {
        return "unknown"
    }
}

func determineColor(_ type: String) -> Color {
    if type=="basso"{
        return Color.red
    }else if type=="vocals"{
        return Color.green
    }else if type=="melody"{
        return Color.pink
    }else{
        return randomColor()
    }
}

// Funzione per generare un colore casuale
func randomColor() -> Color {
    return Color(
        red: Double.random(in: 0.5...1),
        green: Double.random(in: 0.5...1),
        blue: Double.random(in: 0.5...1)
    )
}

