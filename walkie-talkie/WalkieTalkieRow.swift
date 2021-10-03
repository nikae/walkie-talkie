//
//  WalkieTalkieRow.swift
//  walkie-talkie
//
//  Created by Nika Elashvili on 10/2/21.
//

import SwiftUI

struct WalkieTalkieRow: View {
    let name: String
    let color: Color
    let date: String
    
    private let gradient = LinearGradient(
         colors: [Color(.systemGray6),Color(.systemGray5)],
         startPoint: .topTrailing,
         endPoint: .bottomLeading)
    
    private var namePrefix: String {
        name.getprefix?.uppercased() ?? ""
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                ProfileImage(character: namePrefix, color: color)
                    .padding()
                VStack(alignment: .leading) {
                    Text(name.capitalized)
                        .font(.system(.title))
                        .fontWeight(.semibold)
                    Text(date)
                        .font(.system(.body))
                }
                .padding(.vertical)
                .padding(.trailing)
                Spacer()
            }
            .background(RoundedRectangle(cornerRadius: 20)
                            .fill(gradient))
            Spacer()
        }
    }
    
}

struct WalkieTalkieRow_Previews: PreviewProvider {
    static var previews: some View {
        WalkieTalkieRow(name: "Nika",
                        color: Color(.systemBlue),
                        date: "October 2")
            .padding()
    }
}


