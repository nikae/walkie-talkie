//
//  RecordView.swift
//  walkie-talkie
//
//  Created by Nika Elashvili on 10/2/21.
//

import SwiftUI

struct RecordView: View {
    @State private var isPressed = false
    @EnvironmentObject var handler: ContentViewHandler
    @State var id = 40000 //Used for creating new Message object
    
    let user: String
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
                    }
                } onRelease: {
                    isPressed = false
                    print("Released")
                    id += 1
                    let message =
                    Message(id: id,
                            username_from: UserHandler.shared.user.userName,
                            timestamp: "\(Date().timeIntervalSince1970)",
                            recording: "",
                            username_to: user)
                    handler.friendsDictionary[user]?.messages.append(message)
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
        RecordView(user: "")
    }
}


