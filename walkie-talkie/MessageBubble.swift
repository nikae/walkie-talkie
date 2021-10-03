//
//  MessageBubble.swift
//  walkie-talkie
//
//  Created by Nika Elashvili on 10/2/21.
//

import SwiftUI

struct MessageBubble: View {
    @ObservedObject var handler = MessageBubbleHandler()
    
    let color: Color
    let message: Message
    let isCurrentUser: Bool
    
    private var bubbleColor: Color {
        isCurrentUser ? Color(.systemGray2) : color
    }
    
    private var corners: UIRectCorner {
        if isCurrentUser {
            return [.topLeft, .topRight, .bottomLeft]
        } else {
            return [.topLeft, .topRight, .bottomRight]
        }
    }
    
    private var playIconName: String {
        handler.isAudioPlaying ? "stop.circle.fill" : "play.circle.fill"
    }
    
    var body: some View {
        HStack {
            if isCurrentUser {
                Spacer()
            }
            HStack {
                VStack(alignment: .leading) {
                    Text((message.username_from ?? "_").capitalized)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .allowsTightening(true)
                    Text((Double(message.timestamp) ?? 1).convertDate)
                        .font(.subheadline)
                }
                .padding(.trailing)
                
                Image(systemName: playIconName)
                    .font(.largeTitle)
            }
            .foregroundColor(.white)
            .lineLimit(nil)
            .padding()
            .background(bubbleColor.cornerRadius(20, corners: corners))
            .onTapGesture {
                if handler.isAudioPlaying {
                    handler.stopMessage()
                } else {
                    handler.playMessage()
                }
            }
            if !isCurrentUser {
                Spacer()
            }
        }
        .onDisappear {
            handler.stopMessage()
        }
        .alert(isPresented: $handler.showAlert) {
            Alert(title: Text(handler.alertMessage), dismissButton: .cancel())
        }
    }
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        MessageBubble(color: testFriend.color,
                      message: testMessage,
                      isCurrentUser: false)
            .padding()
    }
}

