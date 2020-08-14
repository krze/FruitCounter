//
//  MutableFruitLog.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 8/14/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import Foundation
import Combine

final class MutableFruitLog: ObservableObject {
    
    let fruit: Fruit
    @Published var date: Date
    @Published var rating: Rating
    
    init(fruit: Fruit, date: Date, rating: Rating) {
        self.fruit = fruit
        self.date = date
        self.rating = rating
    }
    
    func makeFruitLog() -> FruitLog {
        FruitLog(fruit: fruit, rating: rating, dateConsumed: date)
    }
}
