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
    @Published var isRefreshing: Bool = false
  
    //MARK: ADMIN
    @Published var admin_AllUsers: [String] = []
    private var admin_LocalList: [Message] = []
    
    init() {
        configure()
    }
    
    private func configure() {
        if UserHandler.shared.user.isAdmin {
            admin_queryItemsFromDB()
        } else {
            queryItemsFromDB()
        }
    }
    
    func queryItemsFromDB() {
        DispatchQueue.main.async {
            self.isLoading = self.friendsDictionary.isEmpty //This should not effect pull to refresh
        }
        netHandler.queryHistory { messages, error in
            if let messages = messages {
                DispatchQueue.global(qos: .userInitiated).async {
                    //Put this on a different thread not to block the main thread
                    let output = self.filterAndGroupData(messages, currentUseID:  UserHandler.shared.user.userName)
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.isRefreshing = false
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
    
    /// Provides either a full array of  Friends or filtered based on search text.
    /// - Returns: Filtered array of friends
    func getFilteredFriends() -> [Friend] {
        if searching {
           return friendsDictionary.values
                .filter { $0.name.contains(searchText.lowercased()) }
                .sorted { $0.name < $1.name }
        } else {
            return friendsDictionary.values.sorted{ $0.lastInteractedDate > $1.lastInteractedDate }
            // { $0.name < $1.name }
        }
    }
    
    /// Filters raw data from DB for the current user.
    /// - Parameters:
    ///   - messages: Array of messages. [Message]
    ///   - currentUseID: String
    /// - Returns: Filtered dictionary of friends. [String : Friend].
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

//MARK: Admin
extension ContentViewHandler {
    
    private func admin_queryItemsFromDB() {
        isLoading = true
        netHandler.queryHistory { messages, error in
            if let messages = messages {
                DispatchQueue.global(qos: .userInitiated).async {
                    self.admin_LocalList = messages
                    let output = self.admin_GetAllUsers(messages)
                    DispatchQueue.main.async {
                        self.isLoading = false
                        withAnimation {
                            self.admin_AllUsers = output
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
    
    /// Makes array of unique user names.
    /// - Parameter messages: Raw message data from DB. [Message]
    /// - Returns:  An array of unique user names. [String]
    private func admin_GetAllUsers(_ messages: [Message]) -> [String] {
        var allUsers: [String] = []
        
        for message in messages {
            if let username_from = message.username_from, !allUsers.contains(username_from) {
                allUsers.append(username_from)
            }
            
            if !allUsers.contains(message.username_to) {
                allUsers.append(message.username_to)
            }
        }
       
        return allUsers.sorted { $0 < $1 }
    }
    
    ///Filters raw data from DB for a selected user.
    /// - Parameter userID: String
    func admin_FilterData(_ userID: String) {
        DispatchQueue.global(qos: .userInitiated).async {
            let output = self.filterAndGroupData(self.admin_LocalList, currentUseID: userID)
            
            DispatchQueue.main.async {
                withAnimation {
                    self.friendsDictionary = output
                }
            }
        }
    }
}

//MARK: Delegate
extension ContentViewHandler: UserSettingsViewHandlerDelegate {
    func reloadData() {
        friendsDictionary.removeAll()
        configure()
    }
}
