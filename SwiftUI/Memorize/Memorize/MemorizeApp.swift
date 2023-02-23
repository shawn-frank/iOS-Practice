//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Shawn Frank on 13/2/2023.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(game: game)
        }
    }
}
