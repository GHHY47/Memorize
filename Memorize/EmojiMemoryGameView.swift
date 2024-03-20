//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by He Yan on 2/24/24.
//
//  Note: 
//  hold down option and click for Type Inference
//  Swift is strong Type language, knows all the Type @ compiler time

import SwiftUI

struct EmojiMemoryGameView: View { //"behaves like a.." Function Programming [this contentView behaves like a view]
    @ObservedObject var viewModel: EmojiMemoryGame // Reactive UI: @ObservedObject
    // Array<String> same as [String] same as Type Inference
    let emojies = 
                    [
                        ["🍎","🍎","🍊","🍊","🍌","🍌","🍓","🍓"],
                        ["⚽️","⚽️","🏀","🏀","🏈","🏈","⚾️","⚾️","⛳️","⛳️"],
                        ["🍔","🍔","🍟","🍟","🍕","🍕","🥗","🥗","🌮","🌮","🥟","🥟"]
                    ]
    
    
    
    @State var theme: Int = 0
    @State var cardCount: Int = 8
    var body: some View { //View{"Computed Property"} which is not stored, but computed. Run and assigne some View
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView { //ScrollView
                cards
            }
            Button("Shuffle"){
                viewModel.shuffle()
            }
            Spacer()
            ZStack {
                cardThemeAdjusters
                cardCountAdjusters
            }
        }
        .padding()
    }
    
    var cards: some View {
        //let emojiesRand = emojies[theme].shuffled()
        // LazyVGrid use as less as possible, But HStack use as much as possible
        // LazyVGrid(columns: [GridItem(),GridItem(),GridItem()]) {
        return LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) { //minimum is the width arg
            // HStack inside View NOK doing for loop -> [special view called ForEach]
            //ForEach(emojiesRand.indices, id: \.self) { index in
            //ForEach(0..<cardCount, id: \.self) { index in // for selected range
            ForEach(viewModel.cards.indices, id: \.self) { index in
                //CardView(content: emojiesRand[index])
                //CardView(content: emojies[theme][index])
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
            } // [0..<4] ..< means up to but not included; ... means up to and included
        }
        .foregroundColor(Color.orange)
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(Font.largeTitle)
    }
    
    var cardThemeAdjusters: some View {
        HStack(spacing: 25) { // spacing control
            cardThemeFruit
            cardThemeSport
            cardThemeFood
        }
        .imageScale(.large)
        .font(.body)
        .textScale(.secondary)
    }
    
    //func
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action:{
            cardCount += offset // [internal] vs external parameter names
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojies[theme].count)
    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill") // internal vs [external] parameter names

    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus.fill") // internal vs [external] parameter names
    }
    
    // func theme
    func cardThemeAdjuster(by themeSet: Int, symbol: String, content: String) -> some View {
        Button(action:{
            theme = themeSet
            cardCount = emojies[theme].count // reset cardCount pervent index out of bounds
        }, label: {
            VStack {
                Image(systemName: symbol) // creates an image view using SF Symbols
                Text(content)
            }
        })
        .disabled(theme == themeSet)
        .foregroundColor(theme == themeSet ? .orange : .blue) // Change colors by bool
    }
    
    var cardThemeFruit: some View {
        cardThemeAdjuster(by: 0, symbol: "apple.logo", content: "Fruit")
    }
    
    var cardThemeSport: some View {
        cardThemeAdjuster(by: 1, symbol: "basketball.fill", content: "Sport")
    }
    
    var cardThemeFood: some View {
        cardThemeAdjuster(by: 2, symbol: "fork.knife.circle.fill", content: "Food")
    }

}

struct CardView: View { // View are immutable, (body can changing), vars inside are immutable
//    let content: String // value assigned with CardView(arg) and never change
//    //@State // @State create a pointer, pointer never changes but pointee can change, satisfy the View not change rule
//    @State var isFaceUp = false // struct (any struct) has a var and the var must have a value
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View { // View is a struct (condition if switch and local variables) nothing inside can change
        ZStack { //trailing closure syntax, enable to delete () for function call arguments
            let base = RoundedRectangle(cornerRadius: 12) // locals in @ViewBuilder; let never change; Type Inference
            Group { //  like for each of one
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                //Text(card.content).font(.largeTitle)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01) // vertical scale
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0) // (? 1 : 0) set 1/true -> opacity
            base.fill().opacity(card.isFaceUp ? 0 : 1) // fill() is default like stokeBorder; (? 0 : 1) set 0/false -> opacity
        }
//        .onTapGesture {
//            //print("tapped") // print to console (debuging feature)
//            //self.isFaceUp.toggle()
//            isFaceUp.toggle()
//        }
    }
}

//#Preview { // default Preview
//    EmojiMemoryGameView()
//}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
