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
            // title
            Text(viewModel.fruit.emoji).font(viewModel.font)
            // count
            Text("\(viewModel.count)").font(viewModel.font)
            HStack {
                CounterButtonFactory.button(with: .decrement, action: viewModel.decrement)
                CounterButtonFactory.button(with: .increment, action: viewModel.increment)
            }
        }
    }
    
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        let testLogbook = LogBook(userName: "Default Username", logs: [], focusedFruit: .watermelon)
        let viewModel = CounterViewModel(logCoordinator: LogCoordinator(logBook: testLogbook), font: .appBoldFont(size: 69.0))
        let view = CounterView(viewModel: viewModel)
        return view
    }
}
