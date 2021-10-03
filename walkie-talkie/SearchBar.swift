//
//  SearchBar.swift
//  walkie-talkie
//
//  Created by Nika Elashvili on 10/3/21.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchText: String
    @Binding var searching: Bool
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color(.secondarySystemBackground))
                .overlay(textField)
            
            if searching {
                Spacer()
                Button("Cancel") {
                    searchText = ""
                    withAnimation {
                        searching = false
                        UIApplication.shared.dismissKeyboard()
                    }
                }
            }
        }
        .frame(height: 40)
        .padding()
    }
    
    private var textField: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search ..", text: $searchText) { startedEditing in
                if startedEditing {
                    withAnimation {
                        searching = true
                    }
                }
            } onCommit: {
                searchText = ""
                withAnimation {
                    searching = false
                }
            }
        }
        .foregroundColor(.gray)
        .padding(.leading, 13)
    }
}


struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant("test"),
                  searching: .constant(true))
    }
}
