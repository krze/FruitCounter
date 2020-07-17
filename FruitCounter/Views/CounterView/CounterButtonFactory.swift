//
//  CounterButtonFactory.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 7/3/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import SwiftUI

struct CounterButtonFactory {

    static func button(with viewModel: CounterButtonViewModel, action: @escaping () -> Void) -> some View {
        let direction = viewModel.direction
        return Button(action: action) {
            Text(direction.rawValue)
                .frame(minWidth: 0, maxWidth: viewModel.buttonSize, minHeight: 0, maxHeight: viewModel.buttonSize)
                .background(direction.backgroundColor())
                .foregroundColor(direction.foregroundColor())
                .font(viewModel.font)
                .cornerRadius(viewModel.cornerRadius)
                .padding(viewModel.padding)
        }
    }
    
}
