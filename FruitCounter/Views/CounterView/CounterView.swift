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
    
    @State var viewModel: CounterViewModel = .default
    @State var titleText = ""
    @State var count = ""
    @State var font: Font = .appBoldFont(size: 20.0)
    
    // MARK: - Body

    var body: some View {
        VStack(content: {
            // title
            Text(titleText).font(self.font)
            // count
            Text(count).font(self.font)
            HStack {
                CounterButtonFactory.button(with: .decrement, action: {
                    self.viewModel.count = self.viewModel.count - 1
                    self.update(with: self.viewModel)
                })
                CounterButtonFactory.button(with: .increment, action: {
                    self.viewModel.count = self.viewModel.count + 1
                    self.update(with: self.viewModel)
                })
            }
            })
            .onAppear {
                self.titleText = self.viewModel.fruit.emoji
                self.count = "\(self.viewModel.count)"
                self.font = self.viewModel.font
            }
    }
    
    private func update(with viewModel: CounterViewModel) {
        titleText = viewModel.fruit.emoji
        count = "\(viewModel.count)"
        font = viewModel.font
    }
    
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        let testFruit = Fruit(name: "Eggplant", emoji: "🍆")
        let viewModel = CounterViewModel(fruit: testFruit, count: 69, font: .appBoldFont(size: 69.0))
        let view = CounterView(viewModel: viewModel, titleText: viewModel.fruit.emoji, count: "\(viewModel.count)", font: viewModel.font)
        return view
    }
}
