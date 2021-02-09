//
//  Cardify.swift
//  Memorize
//
//  Created by Александр Фомичев on 26.01.2021.
//  Copyright © 2021 Fomichev Alexander. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var rotation : Double
    var animatableData : Double{
        get {rotation}
        set {rotation = newValue}
    }
    var isFaceUp : Bool {
        rotation < 90
    }
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    func body(content: Content) -> some View {
        let cornerRaious: CGFloat = 10.0
        let edgeLineWidth: CGFloat = 3.0
        return ZStack{
            Group{
                RoundedRectangle(cornerRadius: cornerRaious).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRaious).stroke(lineWidth: edgeLineWidth)
                content
            }.opacity(isFaceUp ? 1 : 0)
            RoundedRectangle(cornerRadius: cornerRaious).fill().opacity(isFaceUp ? 0 : 1)
            
        }.rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
    }
}

extension View {
    func cardify(isfaceUp : Bool) -> some View{
        self.modifier(Cardify(isFaceUp: isfaceUp))
    }
}


