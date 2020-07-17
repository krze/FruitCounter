//
//  FruitLogListView.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 7/17/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import SwiftUI

struct FruitLogListView: View {
    @ObservedObject var viewModel: FruitLogListViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.latestLogs(), id: \.hashValue) { fruitLog in
                FruitLogView(fruitEmoji: fruitLog.fruit.emoji, date: fruitLog.dateConsumed, rating: fruitLog.rating, font: self.viewModel.font)
            }
        }
    }
}

struct FruitLogListView_Previews: PreviewProvider {
    static var previews: some View {
        let testLogbook = LogBook(userName: "Default Username", logs: [], focusedFruit: .watermelon)
        let logCoordinator = LogCoordinator(logBook: testLogbook, dataCoordinator: DataCoordinator())
        let viewModel = FruitLogListViewModel(logCoordinator: logCoordinator, fruit: .watermelon, font: .appFont(size: 24.0))
        return FruitLogListView(viewModel: viewModel)
    }
}
