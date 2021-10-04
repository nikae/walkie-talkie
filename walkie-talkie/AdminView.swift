//
//  AdminView.swift
//  walkie-talkie
//
//  Created by Nika Elashvili on 10/3/21.
//

import SwiftUI

struct AdminView: View {
    @EnvironmentObject var handler: ContentViewHandler
    
    @State var selectedTable: Int?
    
    var body: some View {
        List {
            if handler.isLoading {
                Text("Loading ...")
                    .alert(isPresented: $handler.showAlert) {
                        Alert(title: Text(handler.alertMessage), dismissButton: .cancel())
                    }
            } else {
                ForEach(handler.admin_AllUsers.indices, id: \.self) { index in
              
                    
                    NavigationLink(tag: index,
                                   selection: self.customBinding()) {
                        destination
                    } label: {
                        Text(handler.admin_AllUsers[index].capitalized)
                    }
                }
            }
        }
        .navigationTitle(Text("Admin"))
    }
    
    func customBinding() -> Binding<Int?> {
            let binding = Binding<Int?>(get: {
                self.selectedTable
            }, set: {
                if let index = $0 {
                    let selectedUser = handler.admin_AllUsers[index]
                    handler.admin_FilterData(selectedUser)
                }
                self.selectedTable = $0
            })
            return binding
        }
    
    private var destination: some View {
        WalkieTalkieView(friends: handler.getFilteredFriends())
            .environmentObject(handler)
    }
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
