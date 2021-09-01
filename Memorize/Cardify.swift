//
//  Cardify.swift
//  Memorize
//
//  Created by Jorge Encinas on 26/08/21.
//  Copyright © 2021 Jorge Encinas. All rights reserved.
//

import SwiftUI


struct Cardify: AnimatableModifier {
    
    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 3
    
    var rotation: Double
    
    var isFaceUp: Bool{
        rotation < 90
    }
    
    var animatableData: Double{
        get {return rotation}
        set {rotation = newValue}
    }
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    func body(content: Content) -> some View {
        ZStack{
            
          Group{
                RoundedRectangle(cornerRadius: self.cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: self.cornerRadius).stroke(lineWidth: self.edgeLineWidth)
                content
            }
          .opacity(isFaceUp ? 1 : 0)
        
            RoundedRectangle(cornerRadius: self.cornerRadius).fill(Color.orange)
                .opacity(isFaceUp ? 0 : 1)
            
        }
        .rotation3DEffect(
            Angle.degrees(rotation),
            axis: (0,1,0)
        )
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
    
}
