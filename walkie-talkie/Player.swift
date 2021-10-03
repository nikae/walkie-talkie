//
//  Player.swift
//  walkie-talkie
//
//  Created by Nika Elashvili on 10/3/21.
//

import Foundation
import AVFoundation

class Player {
    var player : AVPlayer?
    
    func play(completion: @escaping (_ success: Bool, Error?)->()) {
        guard let url = URL(string: "http://192.168.1.50:3000/recording")else {
            completion(false, CustomError.incorrectURL)
            return
        }
        
        do {
            try AVAudioSession.sharedInstance()
                .setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = AVPlayer(url: url as URL)
            guard let player = player else {
                completion(false, CustomError.AVPlayerNotFound)
                return
            }
            completion(true, nil)
            player.play()
        } catch let error {
            completion(false, error)
        }
    }
    
    func stop() {
        player?.pause()
        player = nil
    }
}

