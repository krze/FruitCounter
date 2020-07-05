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
                CounterButtonFactory.button(with: .decrement, action: self.viewModel.decrement)
                CounterButtonFactory.button(with: .increment, action: self.viewModel.increment)
            }
            })
    }
    
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CounterViewModel(logCoordinator: LogCoordinator(), font: .appBoldFont(size: 69.0))
        let view = CounterView(viewModel: viewModel)
        return view
    }
}
