//
//  UserSettingsView.swift
//  walkie-talkie
//
//  Created by Nika Elashvili on 10/3/21.
//

import SwiftUI

protocol UserSettingsViewHandlerDelegate: AnyObject {
    func reloadData()
}

class UserSettingsViewHandler: ObservableObject {
    @Published var isOn = false
    @Published var userName = ""
    
    @Published var updatedName = "Tap"
    
    weak var delegate: UserSettingsViewHandlerDelegate?
    
    init() {
        isOn = UserHandler.shared.user.isAdmin
        userName = UserHandler.shared.user.userName
    }
    
    func updateUserName(_ newName: String) {
        Preferences.userName = newName
        UserHandler.shared.user.userName = newName
        delegate?.reloadData()
    }
    
    func updateAdminStatus(_ isAdmin: Bool) {
        Preferences.isAdmin = isAdmin
        UserHandler.shared.user.isAdmin = isAdmin
        delegate?.reloadData()
    }
}

struct UserSettingsView: View {
    @EnvironmentObject var handler: UserSettingsViewHandler
   
    var body: some View {
        Form {
            Section(header: Text("User")) {
                TextField("User Name:", text: $handler.userName)
                    .onReceive(handler.$userName) {
                        handler.updateUserName($0)
                    }
            }
            
            Section(header: Text("Admin")) {
                Toggle("Admin \(handler.isOn ? "On" : "Off")",
                       isOn: $handler.isOn)
                    .onReceive(handler.$isOn) {
                        handler.updateAdminStatus($0)
                    }
            }
            
//            Text(handler.updatedName)
//                .onTapGesture {
//                    handler.updatedName = "shared \(UserHandler.shared.user.userName)"
//            }
        }
    }
}

struct UserSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        UserSettingsView()
    }
}
