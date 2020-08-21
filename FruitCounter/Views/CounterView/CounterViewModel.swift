//
//  CounterViewModel.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 7/3/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import Combine
import SwiftUI

final class CounterViewModel: ObservableObject, Identifiable {
    
    @Published private(set) var backgroundColor: UIColor = .white
    @Published private(set) var fruit: Fruit
    @Published private(set) var count: Int
    @ObservedObject private var logCoordinator: LogCoordinator
    
    let font: Font
    
    private var disposables = Set<AnyCancellable>()
    
    init(logCoordinator: LogCoordinator, font: Font) {
        self.fruit = logCoordinator.currentLogBook.focusedFruit
        self.count = logCoordinator.currentLogBook.currentlyFocusedLogs.count
        self.logCoordinator = logCoordinator
        self.font = font
        
        DispatchQueue.main.async {
            self.backgroundColor = self.fruit.backgroundColor()
        }
        
        disposables.insert(
            logCoordinator.$currentLogBook
            .map { logBook -> (fruit: Fruit, count: Int) in
                (logBook.focusedFruit, logBook.currentlyFocusedLogs.count)
            }
            .receive(on: DispatchQueue.main)
            .sink { (fruit: Fruit, count: Int) in
            self.fruit = fruit
            self.count = count
                DispatchQueue.main.async {
                    self.backgroundColor = self.fruit.backgroundColor()
                }
            }
        )
    }
    
    deinit {
        disposables.forEach { $0.cancel() }
    }
    
    func increment() {
        logCoordinator.add(FruitLog(fruit: fruit, dateConsumed: Date()))
    }
    
    func decrement() {
        do {
            try logCoordinator.removeMostRecent(fruit)
        }
        catch let error {
            print(error)
        }
    }

}
