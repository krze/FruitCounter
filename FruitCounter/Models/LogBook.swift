//
//  LogBook.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 7/3/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import Foundation

struct LogBook: Codable {
    
    let userName: String
    let logs: [FruitLog]
    let focusedFruit: Fruit
    
    var currentlyFocusedLogs: [FruitLog] {
        return logs.filter { $0.fruit == focusedFruit }
    }
    
    /// Generates a new LogBook with the added log
    func add(_ newLog: FruitLog) -> LogBook {
        var mutableLogs = logs
        mutableLogs.append(newLog)
        
        return LogBook(userName: userName, logs: mutableLogs, focusedFruit: focusedFruit)
    }
    
    /// Generates a new LogBook with the removed log
    func remove(_ log: FruitLog) throws -> LogBook {
        var mutableLogs = logs
        guard let index = mutableLogs.firstIndex(of: log) else { throw LogError.logNotFound(log) }
        
        mutableLogs.remove(at: index)
        
        return LogBook(userName: userName, logs: mutableLogs, focusedFruit: focusedFruit)
    }
    
    /// Changes the currently focused fruit
    func change(focusedFruit: Fruit) -> LogBook {
        return LogBook(userName: userName, logs: logs, focusedFruit: focusedFruit)
    }
    
    /// Changes the current username
    func change(userName: String) -> LogBook {
        return LogBook(userName: userName, logs: logs, focusedFruit: focusedFruit)
    }
    
    enum LogError: Error {
        case noRecordsForFruit(Fruit), logNotFound(FruitLog)
    }
    
}
