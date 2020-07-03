//
//  CounterView.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 7/3/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import Combine
import SwiftUI

struct CounterView: View {
    
    @ObservedObject var viewModel: CounterViewModel

    // MARK: - Body

    var body: some View {
        VStack(content: {
            // title
            Text(viewModel.fruit.emoji).font(viewModel.font)
            // count
            Text("\(viewModel.count)").font(viewModel.font)
            HStack {
                CounterButtonFactory.button(with: .decrement, action: {
                    self.viewModel.count = self.viewModel.count - 1
                })
                CounterButtonFactory.button(with: .increment, action: {
                    self.viewModel.count = self.viewModel.count + 1
                })
            }
            })
    }
    
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        let testFruit = Fruit(name: "Eggplant", emoji: "🍆")
        let viewModel = CounterViewModel(fruit: testFruit, count: 69, font: .appBoldFont(size: 69.0))
        let view = CounterView(viewModel: viewModel)
        return view
    }
}
