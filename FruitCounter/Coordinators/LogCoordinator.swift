//
//  LogCoordinator.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 7/3/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import Combine

final class LogCoordinator: ObservableObject {
    
    @Published private(set) var currentLogBook: LogBook
    
    init() {
        self.currentLogBook = LogBook(userName: "", logs: [], focusedFruit: .watermelon)
    }
    
    init(logBook: LogBook) {
        currentLogBook = logBook
    }
    
    /// Changes focus to the fruit specified
    func change(to fruit: Fruit) {
        currentLogBook = currentLogBook.change(focusedFruit: fruit)
    }
    
    /// Changes the username
    func change(username: String) {
        currentLogBook = currentLogBook.change(userName: username)
    }
    
    ///
    func add(_ log: FruitLog) {
        currentLogBook = currentLogBook.add(log)
    }
    
    func removeMostRecent(_ fruit: Fruit) {
        guard let newest = currentLogBook
            .logs
            .filter({ $0.fruit == fruit })
            .sorted(by: { $0.dateConsumed.compare($1.dateConsumed) == .orderedDescending })
            .first
            else {
                return
        }
        
        currentLogBook = currentLogBook.remove(newest)
    }
    
    func remove(_ log: FruitLog) {
        currentLogBook = currentLogBook.remove(log)
    }
    
    func replace(oldLog: FruitLog, with newLog: FruitLog) {
        currentLogBook = currentLogBook.remove(oldLog).add(newLog)
    }
    
}
