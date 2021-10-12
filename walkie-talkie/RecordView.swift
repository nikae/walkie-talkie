//
//  RecordView.swift
//  walkie-talkie
//
//  Created by Nika Elashvili on 10/2/21.
//

import SwiftUI
import AVFoundation

var messageID = 40000 //Used for creating new Message object
struct RecordView: View {
   
    let user: String
    let onSend: (_ message: Message) -> ()
    
    @State private var isPressed = false

    private let BeginRecording: SystemSoundID = 1113
    private let EndRecording: SystemSoundID = 1114
    private let sent: SystemSoundID = 1004
    private func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    var body: some View {
            VStack {
                icon
                Spacer()
            }.frame(height: 80)
            .background(Color(.secondarySystemBackground)
                            .edgesIgnoringSafeArea(.bottom))
                .pressAction {
                    if isPressed != true {
                        isPressed = true
                        print("Pressed")
                        AudioServicesPlaySystemSound(BeginRecording)
                        simpleSuccess()
                    }
                } onRelease: {
                    isPressed = false
                    AudioServicesPlaySystemSound(EndRecording)
                    print("Released")
                    simpleSuccess()
                    messageID += 1
                    let message =
                    Message(id: messageID,
                            username_from: UserHandler.shared.currentUser.userName,
                            timestamp: "\(Date().timeIntervalSince1970)",
                            recording: "",
                            username_to: user)
                    onSend(message)
                    AudioServicesPlaySystemSound(sent)
                }
    }
    
    private var icon: some View {
        HStack {
            Spacer()
            if isPressed {
                animation
            } else {
                recordIcon
            }
            Spacer()
        }
    }
    
    private var animation: some View {
        HStack {
            Spacer()
        WaveAnimation(color: Color(.label))
                .frame(width: 60, height: 50, alignment: .center)
            .padding()
            Spacer()
        }
    }
    
    private var recordIcon: some View {
        VStack(spacing: 6) {
            Image(systemName: "record.circle")
                .font(.largeTitle)
            Text("Press And Hold To Record")
                .font(.footnote)
        }
        .padding()
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(user: "") { _ in }
    }
}


