//
//  PlaySound.swift
//  DrawingApp
//
//  Created by Muhammad Nur Faqqih on 20/05/22.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSoundRepeat(sound: String, type: String){
    
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.volume = 0.05
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.play()
            
        } catch {
            print("ERROR : Cound not find and play the sound ! (REPEAT)")
            
        }
        
    }
    
    
}

func playSoundOnce(sound: String, type: String){
    
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.volume = 1
            audioPlayer?.numberOfLoops = 0
            audioPlayer?.play()
            
        } catch {
            print("ERROR : Cound not find and play the sound ! (REPEAT)")
            
        }
        
    }
    
    
}
