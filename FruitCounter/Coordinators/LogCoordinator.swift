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
    
    init(logBook: LogBook) {
        currentLogBook = logBook
        self.dataCoordinator = DataCoordinator()
        self.dataCoordinator.fetchLatest(userName: logBook.userName, loadSubscriber: LoadSubscriber { encodedData in
            do {
                let data = try JSONSerialization.data(withJSONObject: encodedData)
                self.currentLogBook = try JSONDecoder().decode(LogBook.self, from: data)
            }
            catch let error {
                print(error)
            }
        })

        $currentLogBook.subscribe(dataCoordinator)
    }
    
    /// Changes focus to the fruit specified
    func change(to fruit: Fruit) {
        currentLogBook = currentLogBook.change(focusedFruit: fruit)
    }
    
    /// Changes the username
    func change(username: String) {
        currentLogBook = currentLogBook.change(userName: username)
    }
    
    /// Adds the given log to the logbook
    func add(_ log: FruitLog) {
        currentLogBook = currentLogBook.add(log)
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
    
}
