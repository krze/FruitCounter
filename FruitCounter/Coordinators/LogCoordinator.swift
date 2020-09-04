//
//  LogCoordinator.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 7/3/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import Combine
import Foundation

final class LogCoordinator: ObservableObject {
    
    @Published private(set) var currentLogBook: LogBook
    
    private var dataCoordinator: DataCoordinator
    
    init(logBook: LogBook, dataCoordinator: DataCoordinator) {
        currentLogBook = logBook
        self.dataCoordinator = dataCoordinator

        $currentLogBook.subscribe(dataCoordinator)
    }
    
    /// Changes focus to the fruit specified
    func change(to fruit: Fruit) {
        DispatchQueue.main.async {
            self.currentLogBook = self.currentLogBook.change(focusedFruit: fruit)
        }
    }
    
    /// Changes the username
    func change(username: String) {
        DispatchQueue.main.async {
            self.currentLogBook = self.currentLogBook.change(userName: username)
        }
    }
    
    /// Adds the given log to the logbook
    func add(_ log: FruitLog) {
        DispatchQueue.main.async {
            self.currentLogBook = self.currentLogBook.add(log)
        }
    }
    
    /// Removes the most recent log for the specified fruit
    func removeMostRecent(_ fruit: Fruit) throws {
        guard let newest = currentLogBook
            .logs
            .filter({ $0.fruit == fruit })
            .sorted(by: { $0.dateConsumed.compare($1.dateConsumed) == .orderedDescending })
            .first
            else {
                throw LogBook.LogError.noRecordsForFruit(fruit)
        }
        
        do {
            currentLogBook = try currentLogBook.remove(newest)
        }
        catch let error {
            print(error)
        }
    }
    
    func remove(_ log: FruitLog) {
        do {
            currentLogBook = try currentLogBook.remove(log)
        }
        catch let error {
            print(error)
        }
    }
    
    func replace(oldLog: FruitLog, with newLog: FruitLog) {
        do {
            currentLogBook = try currentLogBook.remove(oldLog).add(newLog)
        }
        catch let error {
            print(error)
            currentLogBook = currentLogBook.add(newLog)
        }
    }
    
    func remove(at indexSet: IndexSet) {
        currentLogBook = currentLogBook.remove(at: indexSet)
    }
}
