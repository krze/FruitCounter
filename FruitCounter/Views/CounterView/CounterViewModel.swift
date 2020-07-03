//
//  CounterViewModel.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 7/3/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import SwiftUI

final class CounterViewModel: ObservableObject, Identifiable {
    
    @Published var fruit: Fruit
    @Published var count: Int
    let font: Font
    
    init(fruit: Fruit, count: Int, font: Font) {
        self.fruit = fruit
        self.count = count
        self.font = font
    }
    
    static let `default` = CounterViewModel(fruit: .watermelon, count: 0, font: .appBoldFont(size: 69.0))

}
