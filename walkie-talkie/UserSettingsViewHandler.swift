//
//  UserSettingsViewHandler.swift
//  walkie-talkie
//
//  Created by Nika Elashvili on 10/11/21.
//

import Foundation

protocol UserSettingsViewHandlerDelegate: AnyObject {
    func reloadData()
}

class UserSettingsViewHandler: ObservableObject {
    @Published var isOn = false
    @Published var userName = ""
    
    @Published var updatedName = "Tap"
    
    weak var delegate: UserSettingsViewHandlerDelegate?
    
    init() {
        isOn = UserHandler.shared.currentUser.isAdmin
        userName = UserHandler.shared.currentUser.userName
    }
    
    func updateUserName(_ newName: String) {
        Preferences.userName = newName
        UserHandler.shared.currentUser.userName = newName
        delegate?.reloadData()
    }
    
    func updateAdminStatus(_ isAdmin: Bool) {
        Preferences.isAdmin = isAdmin
        UserHandler.shared.currentUser.isAdmin = isAdmin
        delegate?.reloadData()
    }
}
