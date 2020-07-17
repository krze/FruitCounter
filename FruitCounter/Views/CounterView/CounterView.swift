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
        VStack {
            EmojiCounterView(emoji: viewModel.fruit.emoji, count: viewModel.count, font: viewModel.font)
            HorizontalCounterButtonView(leftButtonModel: .decrement,
                                        leftButtonAction: viewModel.decrement,
                                        rightButtonModel: .increment,
                                        rightButtonAction: viewModel.increment)
        }
    }
    
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        let testLogbook = LogBook(userName: "Default Username", logs: [], focusedFruit: .watermelon)
        let viewModel = CounterViewModel(logCoordinator: LogCoordinator(logBook: testLogbook, dataCoordinator: DataCoordinator()), font: .appBoldFont(size: 69.0))
        let view = CounterView(viewModel: viewModel)
        return view
    }
}
