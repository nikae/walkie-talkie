//
//  Preferences.swift
//  walkie-talkie
//
//  Created by Nika Elashvili on 10/3/21.
//

import Foundation

@propertyWrapper
public struct UserDefault<T> {
    let key: String
    let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    public var wrappedValue: T {
        get { UserDefaults.standard.object(forKey: key) as? T ?? defaultValue }
        set { UserDefaults.standard.setValue(newValue, forKey: key) }
    }
}


struct Preferences {
    @UserDefault("USERNAME", defaultValue: "kyle_ski")
    static var userName: String
    
    @UserDefault("ISADMIN", defaultValue: false)
    static var isAdmin: Bool
}
