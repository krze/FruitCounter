//
//  Fruit.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 7/3/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import Foundation

struct Fruit: Codable, Hashable {
    
    let name: String
    let emoji: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(emoji)
    }
    
    
    static let watermelon = Fruit(name: "Watermelon", emoji: "🍉")
}
