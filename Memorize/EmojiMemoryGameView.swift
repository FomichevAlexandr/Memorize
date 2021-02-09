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
    @State var  hasGameStarted: Bool = false
    var body: some View {
        if !hasGameStarted {
            Button(action: {
                hasGameStarted = true
            }, label: {Text("START GAME").font(Font.largeTitle).foregroundColor(Color.black)})
        }
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
                        .onTapGesture {
                            withAnimation(Animation.linear(duration: 0.75)){
                                self.viewModel.choose(card: card)
                            }
                        }
                        .padding(4)
                }
                .padding()
                .foregroundColor(EmojiMemoryGame.theme.color)
                Button(action: {
                    withAnimation(.easeInOut){
                        self.viewModel.resetGame()
                    }
                },label: {Text("NEW GAME").foregroundColor(Color.black)})
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
    
    @State var animatedBonusRamaining : Double = 0
    
    private func startBonusTimeAnimation (){
        animatedBonusRamaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)){
            animatedBonusRamaining = 0
        }
    }
    @ViewBuilder
    private func body(for size: CGSize) -> some View{
        if  card.isFaceUp || !card.isMatched  {
            ZStack{
                Group{
                    if card.isConsumingBonusTime{
                        Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-animatedBonusRamaining * 360 - 90 ),clockwise: true)
                            .onAppear{
                                startBonusTimeAnimation()
                            }
                    }
                    else {
                        Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90 ),clockwise: true)
                    }
                }
                .padding(5)
                .opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isfaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
            
            
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




