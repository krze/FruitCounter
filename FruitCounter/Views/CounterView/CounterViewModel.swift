//
//  CounterViewModel.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 7/3/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import SwiftUI

final class CounterViewModel: ObservableObject, Identifiable {
    
    @Published private(set) var fruit: Fruit
    @Published private(set) var count: Int
    @ObservedObject private var logCoordinator: LogCoordinator
    
    let font: Font
    
    init(fruit: Fruit, count: Int, font: Font) {
        self.fruit = fruit
        self.count = count
        self.font = font
        
        let newBook = LogBook(userName: "", logs: [], focusedFruit: fruit)
        self.logCoordinator = LogCoordinator(logBook: newBook)
        
        // Next: Observe changes to update self
    }
    
    static let `default` = CounterViewModel(fruit: .watermelon, count: 0, font: .appBoldFont(size: 69.0))
    
    func increment() {
        count += 1
        logCoordinator.add(FruitLog(fruit: fruit, dateConsumed: Date()))
    }
    
    func decrement() {
        count -= 1
        logCoordinator.removeMostRecent(fruit)
    }

}
