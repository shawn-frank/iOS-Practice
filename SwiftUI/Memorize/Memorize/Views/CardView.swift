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
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                
                if card.isFaceUp {
                    shape.foregroundColor(.white)
                    Circle().padding(5).opacity(0.5)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth).foregroundColor(.red)
                    Text(card.content).font(font(in: geometry.size))
                }
                else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.75
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let card = MemoryGame<String>.Card(content: "🚅", id: 1)
        CardView(card: card)
    }
}
