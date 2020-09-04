//
//  ThumbButtonStyle.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 9/4/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import SwiftUI

struct ThumbButtonStyle: ButtonStyle {
    var foreground = Color.white
    var background = Color.blue
    
    func makeBody(configuration: Configuration) -> some View {
        Circle()
            .fill(background.opacity(configuration.isPressed ? 0.6 : 1))
            .overlay(Circle().strokeBorder(foreground).padding(3))
            .overlay(configuration.label.font(.appFont(size: 69)))
            .frame(width: 100, height: 100)
            .animation(.linear(duration: 0.1))
    }
    
}
