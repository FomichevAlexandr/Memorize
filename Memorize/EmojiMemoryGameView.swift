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
    @State var  hasGameStarted:Bool = false
    var body: some View {
        if !hasGameStarted{ Button(action: {
            hasGameStarted = true
        }, label: {
            Text("START GAME").font(Font.largeTitle).foregroundColor(Color.black)
        })}
        else{
            VStack{
                HStack{
                    Text(EmojiMemoryGame.theme.name)
                        .font(Font.largeTitle)
                        .foregroundColor(EmojiMemoryGame.theme.color)
                    Text(String(viewModel.score)).font(Font.largeTitle).foregroundColor(Color.black)
                }
                Grid(viewModel.cards){ card in
                    CardView(card: card)
                        .onTapGesture {self.viewModel.choose(card: card)}
                        .padding(4)
                }
                    .padding()
                .foregroundColor(EmojiMemoryGame.theme.color)
            }
        }
    }
}

struct CardView: View{
    var card: MemoryGame<String>.Card
    var body: some View{
        GeometryReader{ geometry in
            self.body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View{
        if (!card.isMatched || card.isFaceUp){
            ZStack{
                Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(100)).padding(5).opacity(0.4)
                Text(card.content).font(Font.system(size: fontSize(for: size)))
            }.cardify(isfaceUp: card.isFaceUp)
        }
    }
    
   private func fontSize(for size: CGSize) -> CGFloat{
        min(size.width, size.height)*0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {

        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}




