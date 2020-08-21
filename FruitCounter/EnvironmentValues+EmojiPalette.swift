//
//  EnvironmentValues+EmojiPalette.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 8/21/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import SwiftUI

struct EmojiColorPalette: EnvironmentKey {
    static var defaultValue: [UIColor] = []
}

extension EnvironmentValues {
    var emojiColorPalette: [UIColor] {
        get { self[EmojiColorPalette.self] }
        set { self[EmojiColorPalette.self] = newValue }
    }
}
