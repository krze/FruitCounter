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
    @ObservedObject var mutableFruitLog: MutableFruitLog
    
    let deletionCallback: () -> Void
    
    @State private var showDatePicker = false
    @State private var shouldSave = true
    
    var body: some View {
        VStack {
            Text(mutableFruitLog.date.localizedDateString()).onTapGesture {
                self.showDatePicker.toggle()
            }
            if showDatePicker {
                DatePicker("", selection: $mutableFruitLog.date, displayedComponents: [.date, .hourAndMinute])
            }
            Text(fruitLogViewModel.fruitLog.fruit.emoji).font(.appFont(size: 69))
            Text(fruitLogViewModel.fruitLog.fruit.name)
            RatingButtons(rating: $mutableFruitLog.rating, viewModel: RatingsButtonViewModel(currentRating: mutableFruitLog.rating))
            Button("🗑", action: remove).font(.appFont(size: 69))
        }
        .font(fruitLogViewModel.font).animation(.easeInOut)
        .onDisappear {
            if self.shouldSave {
                self.fruitLogViewModel.update(with: self.mutableFruitLog.makeFruitLog())
            }
        }
    }
    
    private func remove() {
        fruitLogViewModel.remove(fruitLog: fruitLogViewModel.fruitLog)
        shouldSave = false
        deletionCallback()
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
        return DetailView(fruitLogViewModel: viewModel, mutableFruitLog: fruitLog.getMutableFruitLog(), deletionCallback: {})
    }
}
