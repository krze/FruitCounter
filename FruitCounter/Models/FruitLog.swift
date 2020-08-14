//
//  FruitLog.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 7/3/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import Foundation

struct FruitLog: Codable, Hashable {
    
    let fruit: Fruit
    let rating: Rating
    let dateConsumed: Date
    
    init(fruit: Fruit, dateConsumed: Date) {
        self.fruit = fruit
        self.dateConsumed = dateConsumed
        
        rating = .unrated
    }
    
    init(fruit: Fruit, rating: Rating, dateConsumed: Date) {
        self.fruit = fruit
        self.rating = rating
        self.dateConsumed = dateConsumed
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(fruit)
        hasher.combine(rating)
        hasher.combine(dateConsumed)
    }
    
    /// Generates a new FruitLog with the rating specified
    func changeRating(to newRating: Rating) -> FruitLog {
        return FruitLog(fruit: fruit, rating: newRating, dateConsumed: dateConsumed)
    }
    
    /// Generates a new FruitLog with the date specified
    func changeDate(to newDate: Date) -> FruitLog {
        return FruitLog(fruit: fruit, rating: rating, dateConsumed: newDate)
    }
    
    func getMutableFruitLog() -> MutableFruitLog {
        MutableFruitLog(fruit: fruit, date: dateConsumed, rating: rating)
    }

}
