//
//  CounterButtonViewModel.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 7/3/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import SwiftUI

enum CounterButtonDirection: String {
    
    case increment = "+"
    case decrement = "-"
    
    func backgroundColor() -> Color {
        switch self {
        case .increment:
            return .green
        case .decrement:
            return .red
        }
    }
    
    func foregroundColor() -> Color {
        .white
    }
    
}

struct CounterButtonViewModel {
    
    let font: Font
    let direction: CounterButtonDirection
    let padding: CGFloat
    let cornerRadius: CGFloat
    let buttonSize: CGFloat
    
    static let increment = CounterButtonViewModel(font: .appBoldFont(size: 72.0), direction: .increment, padding: 24.0, cornerRadius: 24.0, buttonSize: 96.0)
    static let decrement = CounterButtonViewModel(font: .appBoldFont(size: 72.0), direction: .decrement, padding: 24.0, cornerRadius: 24.0, buttonSize: 96.0)

}
