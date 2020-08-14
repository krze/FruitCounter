//
//  DetailView.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 8/14/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var fruitLogViewModel: FruitLogViewModel
    
    var body: some View {
        VStack {
            Text(fruitLogViewModel.fruitLog.dateConsumed.localizedDateString())
            Text(fruitLogViewModel.fruitLog.fruit.emoji)
            Text(fruitLogViewModel.fruitLog.fruit.name)
            Text(fruitLogViewModel.fruitLog.rating.emoji)
        }.font(fruitLogViewModel.font)
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let fruit = Fruit(name: "Watermelon", emoji: "🍉")
        let fruitLog = FruitLog(fruit: fruit, dateConsumed: Date())
        let logBook = LogBook(userName: "", logs: [fruitLog], focusedFruit: fruit)
        let dataCoordinator = DataCoordinator()
        let logCoordinator = LogCoordinator(logBook: logBook, dataCoordinator: dataCoordinator)
        let viewModel = FruitLogViewModel(fruitLog: fruitLog, font: .appFont(size: 24), logCooordinator: logCoordinator)
        return DetailView(fruitLogViewModel: viewModel)
    }
}
