//
//  CounterViewModel.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 7/3/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import SwiftUI

struct CounterViewModel {
    
    let fruit: Fruit
    let count: Int
    let font: Font
    
    static let `default` = CounterViewModel(fruit: .watermelon, count: 0, font: .appBoldFont(size: 69.0))

}
