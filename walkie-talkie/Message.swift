//
//  Message.swift
//  walkie-talkie
//
//  Created by Nika Elashvili on 10/2/21.
//

import Foundation
import SwiftUI

struct Friend {
    let id: String
    let name: String
    var messages: [Message]
    let color: Color
   
    var lastInteractedDate: TimeInterval {
        let dates = messages.compactMap { TimeInterval($0.timestamp) }
        return dates.max() ?? 1
    }
}

struct Message: Codable {
    let id: Int
    let username_from: String?
    let timestamp: String
    let recording: String?
    let username_to: String
}
