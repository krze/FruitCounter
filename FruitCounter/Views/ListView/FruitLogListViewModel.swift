//
//  FruitLogListViewModel.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 7/17/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import Combine
import SwiftUI

final class FruitLogListViewModel: ObservableObject {
    @Published private(set) var fruit: Fruit
    @ObservedObject private var logCoordinator: LogCoordinator
    
    let font: Font
    
    private var disposables = Set<AnyCancellable>()
    
    init(logCoordinator: LogCoordinator, fruit: Fruit, font: Font) {
        self.logCoordinator = logCoordinator
        self.fruit = fruit
        self.font = font
        
        disposables.insert(
            logCoordinator.$currentLogBook
            .map { logBook -> Fruit in
                logBook.focusedFruit
            }
            .receive(on: DispatchQueue.main)
            .sink { fruit in
            self.fruit = fruit
            }
        )
    }
    
    func latestLogs() -> [FruitLog] {
        logCoordinator.currentLogBook.logs
    }
    
    func fruitLogViewModel(from fruitLog: FruitLog) -> FruitLogViewModel {
        FruitLogViewModel(fruitLog: fruitLog, font: font, logCooordinator: logCoordinator)
    }
}
