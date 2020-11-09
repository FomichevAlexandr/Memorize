//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Александр Фомичев on 14.08.2020.
//  Copyright © 2020 Fomichev Alexander. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    var body: some View {
        Grid(viewModel.cards){ card in
                CardView(card: card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .onTapGesture {self.viewModel.choose(card: card)}
        }
            .padding()
            .foregroundColor(Color.orange)
    }
    
}


struct CardView: View{
    var card: MemoryGame<String>.Card
    var body: some View{
        GeometryReader{ geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View{
        ZStack{
            if card.isFaceUp{
            RoundedRectangle(cornerRadius: cornerRaious).fill(Color.white)
            RoundedRectangle(cornerRadius: cornerRaious).stroke(lineWidth: edgeLineWidth)
            Text(card.content)
            }
            else{
                RoundedRectangle(cornerRadius: cornerRaious).fill()
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    // MARK: - Drawing Constants
    let cornerRaious: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3.0
    func fontSize(for size: CGSize) -> CGFloat{
        min(size.width, size.height)*0.85
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}




