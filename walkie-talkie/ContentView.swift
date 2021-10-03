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
        if handler.isLoading {
            Text("Loading ...")
        } else {
            mainView
        }
    }
    
    private var mainView: some View {
       
        WalkieTalkieView(friends: handler.getGroupedMessages())
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
