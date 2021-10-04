//
//  ContentView.swift
//  walkie-talkie
//
//  Created by Nika Elashvili on 10/2/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var handler: ContentViewHandler
    
    var body: some View {
        if UserHandler.shared.user.isAdmin {
            AdminView()
                .environmentObject(handler)
        } else {
            mainView
                .environmentObject(handler)
        }
    }
    
    private var mainView: some View {
        WalkieTalkieView(friends: handler.getFilteredFriends())
            .environmentObject(handler)
            .gesture(DragGesture()
                        .onChanged({ _ in
                UIApplication.shared.dismissKeyboard()
            }))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ContentViewHandler())
    }
}
