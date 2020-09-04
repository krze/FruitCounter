//
//  FruitLogViewModel.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 8/14/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import Combine
import SwiftUI

final class FruitLogViewModel: ObservableObject {
    @Published var fruitLog: FruitLog
    let font: Font

    @ObservedObject private var logCoordinator: LogCoordinator
    
    init(fruitLog: FruitLog, font: Font, logCooordinator: LogCoordinator) {
        self.fruitLog = fruitLog
        self.font = font
        self.logCoordinator = logCooordinator
    }
    
    func update(with newLog: FruitLog) {
        logCoordinator.replace(oldLog: fruitLog, with: newLog)
        fruitLog = newLog
    }
    
    func remove(fruitLog: FruitLog) {
        logCoordinator.remove(fruitLog)
    }
}
