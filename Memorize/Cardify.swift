//
//  Cardify.swift
//  Memorize
//
//  Created by Jorge Encinas on 26/08/21.
//  Copyright © 2021 Jorge Encinas. All rights reserved.
//

import SwiftUI


struct Cardify: ViewModifier {
    
    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 3
    
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack{
            
            if isFaceUp{
                RoundedRectangle(cornerRadius: self.cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: self.cornerRadius).stroke(lineWidth: self.edgeLineWidth)
                content
            } else {
                RoundedRectangle(cornerRadius: self.cornerRadius).fill(Color.orange)
            }
        }
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
    
}
