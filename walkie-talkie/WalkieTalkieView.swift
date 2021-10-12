//
//  WalkieTalkieView.swift
//  walkie-talkie
//
//  Created by Nika Elashvili on 10/2/21.
//

import SwiftUI
import CircleLinesAnimation

struct WalkieTalkieView: View {
    @EnvironmentObject var handler: ContentViewHandler
    let friends: [Friend]
    
    private var barTitle: String {
        handler.searching ? "Searching" : "Walkie Talkie"
    }
        
    var body: some View {
        VStack {
            if handler.showSearchBar {
                SearchBar(searchText: $handler.searchText,
                          searching: $handler.searching)
            }
            if handler.isLoading {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        CircleLinesAnimation(height: 50, color: Color(.label))
                        Spacer()
                    }
                    Spacer()
                }
            } else {
                RefreshableScrollView(refreshing: $handler.isRefreshing) {
                    list.padding(.horizontal)
                }
                .onReceive(handler.$isRefreshing) { refreshing in
                    if refreshing {
                        if handler.showSearchBar || UserHandler.shared.currentUser.isAdmin {
                            DispatchQueue.main.async {
                                handler.isRefreshing = false
                            }
                        } else {
                            handler.queryItemsFromDB()
                        }
                    }
                }
            }
        }
        .navigationTitle(barTitle)
        .navigationBarTitleDisplayMode(handler.showSearchBar ? .inline : .automatic)
        .toolbar {
            if !handler.isLoading {
                barButton
            }
        }
        .alert(isPresented: $handler.showAlert) {
            Alert(title: Text(handler.alertMessage), dismissButton: .cancel())
        }
        .onTapGesture {
            handler.isRefreshing = false
        }
        
    }
    
    private var list: some View {
        LazyVStack {
            ForEach(friends, id: \.id) { friend in
                friendRow(friend)
            }
        }
    }
    
    private func friendRow(_ friend: Friend) -> some View {
        NavigationLink(destination: MessagesView(friend: friend)
                .environmentObject(handler)) {
            
            WalkieTalkieRow(name: friend.name,
                            color: friend.color,
                            date: friend.lastInteractedDate.convertDate)
        }
    }
    
    private var barButton: some View {
        Button {
            handler.searchText = ""
            withAnimation {
                handler.searching = false
                handler.showSearchBar.toggle()
            }
        } label: {
            Image(systemName: handler.showSearchBar ? "magnifyingglass.circle.fill" : "magnifyingglass" )
        }
    }
}

struct WalkieTalkieView_Previews: PreviewProvider {
    static var previews: some View {
        WalkieTalkieView(friends: [testFriend, testFriend])
        WalkieTalkieView(friends: [testFriend, testFriend])
            .preferredColorScheme(.dark)
    }
}
