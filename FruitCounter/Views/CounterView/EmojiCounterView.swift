//
//  EmojiCounterView.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 7/17/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import SwiftUI

struct EmojiCounterView: View {
    let emoji: String
    let count: Int
    let font: Font
    
    var body: some View {
        VStack {
            Text(emoji).font(font)
            Text("\(count)").font(font)
        }
    }
}
