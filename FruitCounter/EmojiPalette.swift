//
//  EmojiPalette.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 9/4/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import UIKit

struct EmojiPalette: Equatable {
    
    let primary: UIColor
    let secondary: UIColor
    let tertiary: UIColor
    
    static let blackAndWhite = EmojiPalette(primary: .white, secondary: .black, tertiary: .gray)
}
