//
//  WaveAnimation.swift
//  walkie-talkie
//
//  Created by Nika Elashvili on 10/2/21.
//

import SwiftUI

struct WaveAnimation: View {
    
    let color: Color
    
    @State var isAnimating: Bool = false
    @State var isAnimating2: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            HStack{
                RoundedRectangle(cornerRadius: 2).fill(color)
                    .frame(width: 4, height: geo.size.height * 0.4)
                    .scaleEffect(CGSize(width: 1, height: isAnimating ? 1.2 : 1))
                
                RoundedRectangle(cornerRadius: 2).fill(color)
                    .frame(width: 4, height: geo.size.height * 0.6)
                    .scaleEffect(CGSize(width: 1, height: isAnimating2 ? 1.2 : 1))
                
                RoundedRectangle(cornerRadius: 2).fill(color)
                    .frame(width: 4, height: geo.size.height * 0.8)
                    .scaleEffect(CGSize(width: 1, height: isAnimating ? 1.2 : 1))
                
                RoundedRectangle(cornerRadius: 2).fill(color)
                    .frame(width: 4, height: geo.size.height * 0.6)
                    .scaleEffect(CGSize(width: 1, height: isAnimating2 ? 1.2 : 1))
                
                RoundedRectangle(cornerRadius: 2).fill(color)
                    .frame(width: 4, height: geo.size.height * 0.4)
                    .scaleEffect(CGSize(width: 1, height: isAnimating ? 1.2 : 1))
                
            }
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 0.7).repeatForever()){
                    
                    isAnimating = true
                }
                withAnimation(Animation.easeInOut(duration: 0.7).repeatForever().delay(0.7)){
                    
                    isAnimating2 = true
                }
            }
        }
    }
}

struct WaveAnimation_Previews: PreviewProvider {
    static var previews: some View {
        WaveAnimation(color: Color(.label))
            .preferredColorScheme(.dark)
            .frame(width: 60, height: 50, alignment: .center)
    }
}
