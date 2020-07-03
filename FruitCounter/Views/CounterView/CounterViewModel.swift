//
//  CounterViewModel.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 7/3/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import SwiftUI

final class CounterViewModel {
    
    var fruit: Fruit
    var count: Int
    var font: Font
    
    init(fruit: Fruit, count: Int, font: Font) {
        self.fruit = fruit
        self.count = count
        self.font = font
    }
    
    static let `default` = CounterViewModel(fruit: .watermelon, count: 0, font: .appBoldFont(size: 69.0))

}
