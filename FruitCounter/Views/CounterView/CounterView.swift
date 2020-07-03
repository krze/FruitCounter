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
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            // title
            Text(viewModel.fruit.emoji).font(viewModel.font)
            // count
            Text("\(viewModel.count)").font(viewModel.font)
            HStack {
                CounterButtonFactory.button(with: .decrement, action: {
                    self.viewModel = CounterViewModel(fruit: .watermelon, count: self.viewModel.count - 1, font: .appBoldFont(size: 69.0))
                })
                CounterButtonFactory.button(with: .increment, action: {
                self.viewModel = CounterViewModel(fruit: .watermelon, count: self.viewModel.count + 1, font: .appBoldFont(size: 69.0))
                })
            }
        }
    }
        
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        let view = CounterView()
        return view
    }
}
