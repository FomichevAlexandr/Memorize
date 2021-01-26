//
//  Cardify.swift
//  Memorize
//
//  Created by Александр Фомичев on 26.01.2021.
//  Copyright © 2021 Fomichev Alexander. All rights reserved.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp : Bool
    func body(content: Content) -> some View {
        let cornerRaious: CGFloat = 10.0
        let edgeLineWidth: CGFloat = 3.0
        return ZStack{
            if isFaceUp{
                RoundedRectangle(cornerRadius: cornerRaious).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRaious).stroke(lineWidth: edgeLineWidth)
                content
            }
            else{
                RoundedRectangle(cornerRadius: cornerRaious).fill()
            }
        }
    }
}

extension View {
    func cardify(isfaceUp : Bool) -> some View{
        self.modifier(Cardify(isFaceUp: isfaceUp))
    }
}


