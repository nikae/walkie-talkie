//
//  walkie_talkieApp.swift
//  walkie-talkie
//
//  Created by Nika Elashvili on 10/2/21.
//

import SwiftUI

@main
struct walkie_talkieApp: App {
    let handler = ContentViewHandler()
    let userSettingsViewHandler = UserSettingsViewHandler()
    
    init() {
        userSettingsViewHandler.delegate = handler
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environmentObject(handler)
                    .navigationTitle(Text("Walkie Talkie"))
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            NavigationLink(destination: UserSettingsView()
                                            .environmentObject(userSettingsViewHandler)) {
                                Image(systemName: "person.circle.fill")
                            }
                        }
                    }
            }
            .navigationViewStyle(DoubleColumnNavigationViewStyle())
            .accentColor(Color(.label))
        }
    }
}
