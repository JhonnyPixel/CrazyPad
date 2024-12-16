//
//  SoundPackModel.swift
//  CrazyPad
//
//  Created by francesco trotti on 04/12/24.
//

import Foundation
import SwiftUI
import AVFoundation

struct Soundpack: Identifiable {
    let id = UUID()
    let title: String
    let previewURL: URL?
    let bpm:Double=50
    let backgroundImage: Image?
    let backgroundColor: Color
    let sounds: [Sound]
}

// Model per i suoni del soundpack
struct Sound: Identifiable {
    let id = UUID()
    let name: String
    let type: String // basso, vocals, melody ecc.
    let color: Color
    let fileName:String
    var audioPlayer:AVAudioPlayer?=nil
    let loop:Bool=true
}

/*class Sound: Identifiable {
    let id : UUID
    let name: String
    let type: String // basso, vocals, melody ecc.
    let color: Color
    var fileName:String
    var audioPlayer:AVAudioPlayer?=nil
    var loop:Bool=true
    
    init(id: UUID = UUID(), name: String, type : String, color:Color,fileName: String,loop: Bool = false) {
            self.id = id
            self.name=name
            self.type=type
            self.color=color
            self.fileName = fileName
            self.loop = loop
        }
    
}*/
