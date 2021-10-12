//
//  UserSettingsView.swift
//  walkie-talkie
//
//  Created by Nika Elashvili on 10/3/21.
//

import SwiftUI

struct UserSettingsView: View {
    @EnvironmentObject var handler: UserSettingsViewHandler
   
    var body: some View {
        Form {
            Section(header: Text("User")) {
                TextField("User Name:", text: $handler.userName)
                    .onReceive(handler.$userName) {
                        if UserHandler.shared.currentUser.userName != $0 {
                            handler.updateUserName($0)
                        }
                    }
            }
            
            Section(header: Text("Admin")) {
                Toggle("Admin \(handler.isOn ? "On" : "Off")",
                       isOn: $handler.isOn)
                    .onReceive(handler.$isOn) {
                        if UserHandler.shared.currentUser.isAdmin != $0 {
                            handler.updateAdminStatus($0)
                        }
                    }
            }
        }
    }
}

struct UserSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        UserSettingsView()
    }
}
