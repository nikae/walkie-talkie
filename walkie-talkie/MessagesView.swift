//
//  MessagesView.swift
//  walkie-talkie
//
//  Created by Nika Elashvili on 10/2/21.
//

import SwiftUI

struct MessagesView: View {
    @EnvironmentObject var handler: ContentViewHandler
    @State var friend: Friend
    
    let currentUser = UserHandler.shared.currentUser
  
    var body: some View {
        VStack {
            ScrollView {
                list
                    .padding()
            }
            if !UserHandler.shared.currentUser.isAdmin {
                RecordView(user: friend.name) { message in
                    friend.messages.append(message)
                }
            }
        }
        .navigationTitle(friend.name.capitalized)
        .onDisappear {
            handler.friendsDictionary[friend.name]?.messages = friend.messages
        }
           
    }
    
    private var list: some View {
        LazyVStack {
            ForEach(friend.messages, id: \.id) { message in
                MessageBubble(color: friend.color, message:message,
                              isCurrentUser: isCurrentUser(message.username_from ?? ""))
            }
        }
    }
    
    private func isCurrentUser(_ id: String) -> Bool {
        id == currentUser.userName
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView(friend: testFriend)
    }
}
