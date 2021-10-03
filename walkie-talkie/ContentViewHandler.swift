//
//  ContentViewHandler.swift
//  walkie-talkie
//
//  Created by Nika Elashvili on 10/2/21.
//

import Foundation
import SwiftUI


class ContentViewHandler: ObservableObject {
    let netHandler = NetworkHandler()
    
    @Published var friendsDictionary: [String: Friend] = [:]
    @Published var isLoading: Bool = false
    @Published var showSearchBar: Bool = false
    @Published var searchText: String = ""
    @Published var searching: Bool = false
    @Published var alertMessage: String = ""
    @Published var showAlert: Bool = false
    
    init() {
        queryItemsFromDB {_ in }
    }
    
    func queryItemsFromDB(completion: @escaping (_ successes: Bool)->()) {
        isLoading = self.friendsDictionary.isEmpty //This should not effect pull to refresh
        netHandler.queryHistory { messages, error in
            //TODO: Handle Error
            if let messages = messages {
                DispatchQueue.global(qos: .userInitiated).async {
                    //Put this on a different thread not to block the main thread
                    let output = self.filterAndGroupData(messages, currentUseID:  UserHandler.shared.user.userName)
                    DispatchQueue.main.async {
                        self.isLoading = false
                        completion(true)
                        withAnimation {
                            self.friendsDictionary = output
                        }
                    }
                }
            }
            
            if let error = error {
                DispatchQueue.main.async {
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                }
            }
        }
    }
    
    
    func getGroupedMessages() -> [Friend] {
        if searching {
           return friendsDictionary.values
                .filter { $0.name.contains(searchText.lowercased()) }
                .sorted { $0.name < $1.name }
        } else {
            return friendsDictionary.values.sorted{ $0.lastInteractedDate > $1.lastInteractedDate }
            // { $0.name < $1.name }
        }
    }
    
    
    func filterAndGroupData(_ messages: [Message], currentUseID: String) ->  [String : Friend] {
        var output = [String : Friend]()
        
        //Filter messages for the current user
        let filteredMessages = messages.filter { $0.username_from == currentUseID || $0.username_to == currentUseID}
       
        for message in filteredMessages {
            let key: String
            
            //Make sure key is not the current user
            if message.username_from != currentUseID {
                guard let username_from = message.username_from else { continue }
                key = username_from
            } else {
                key = message.username_to
            }
            
            //Check if the group already exists
            if output.keys.contains(where: { $0 == message.username_from || $0 == message.username_to }) {
                //Add message to the group
                output[key]?.messages.append(message)
            } else {
                //Create a new group
                output[key] = Friend(
                    id: key,
                    name: key,
                    messages: [message],
                    color: Color(UIColor.random))
            }
        }
        
        
      return output
    }
}
