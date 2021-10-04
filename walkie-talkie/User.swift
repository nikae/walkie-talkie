//
//  User.swift
//  walkie-talkie
//
//  Created by Nika Elashvili on 10/2/21.
//

import Foundation


struct User {
    let id = UUID()
    var userName: String
    var isAdmin: Bool
}

/// UserHandler class is a singleton that allows us to maintain consistency throughout the app
class UserHandler {
    static let shared = UserHandler()
    var user: User
    init() {
        user = User(userName: Preferences.userName, isAdmin: Preferences.isAdmin)
    }
}
