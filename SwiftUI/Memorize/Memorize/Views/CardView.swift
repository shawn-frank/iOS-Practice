//
//  CardView.swift
//  Memorize
//
//  Created by Shawn Frank on 13/2/2023.
//

import SwiftUI

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: 25.0)
                
                if card.isFaceUp {
                    shape.foregroundColor(.white)
                    shape.strokeBorder(lineWidth: 3).foregroundColor(.red)
                    Text(card.content).font(Font.system(size: min(geometry.size.width, geometry.size.height) * 0.8))
                }
                else if card.isMatched {
                    shape.opacity(0)
                }
                else {
                    shape.foregroundColor(.red)
                }
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let card = MemoryGame<String>.Card(content: "🚅", id: 1)
        CardView(card: card)
    }
}
