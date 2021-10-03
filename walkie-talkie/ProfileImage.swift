//
//  ProfileImage.swift
//  walkie-talkie
//
//  Created by Nika Elashvili on 10/3/21.
//

import SwiftUI

struct ProfileImage: View {
    let character: String
    let color: Color
    
    var body: some View {
        ZStack {
            Circle().fill(color)
            Text(character)
                .foregroundColor(.white)
                .font(.system(size: 30))
                .lineLimit(1)
                .minimumScaleFactor(0.2)
                .padding()
        }.frame(width: 70, height: 70)
    }
}

struct ProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImage(character: testFriend.name.getprefix?.uppercased() ?? "",
                     color: .black)
    }
}
