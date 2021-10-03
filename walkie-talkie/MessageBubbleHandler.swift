//
//  MessageBubbleHandler.swift
//  walkie-talkie
//
//  Created by Nika Elashvili on 10/3/21.
//

import Foundation

class MessageBubbleHandler: ObservableObject {
    let player = Player()
    
    @Published var alertMessage: String = ""
    @Published var showAlert: Bool = false
    @Published var isAudioPlaying: Bool = false
    
    func playMessage() {
        if isAudioPlaying {
            stopMessage()
        }
        
        player.play { success, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                } else {
                    self.isAudioPlaying = success
                }
            }
        }
    }
    
    func stopMessage() {
        player.stop()
        self.isAudioPlaying = false
    }
}

