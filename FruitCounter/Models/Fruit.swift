//
//  Fruit.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 7/3/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import ColorThiefSwift
import Foundation

struct Fruit: Codable, Hashable {
    
    let name: String
    let emoji: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(emoji)
    }
    
    func palette() -> EmojiPalette {
        var colors = EmojiColorThief.getPalette(from: emoji)
        
        return EmojiPalette(primary: colors.removeFirst(), secondary: colors.removeFirst(), tertiary: colors.removeFirst())
    }
    
    static let watermelon = Fruit(name: "Watermelon", emoji: "🍉")
}
