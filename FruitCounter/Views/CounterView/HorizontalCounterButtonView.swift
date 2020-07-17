//
//  HorizontalCounterButtonView.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 7/17/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import SwiftUI

struct HorizontalCounterButtonView: View {
    let leftButtonModel: CounterButtonViewModel
    let leftButtonAction: () -> Void
    let rightButtonModel: CounterButtonViewModel
    let rightButtonAction: () -> Void
    
    var body: some View {
        HStack {
            CounterButtonFactory.button(with: leftButtonModel, action: leftButtonAction)
            CounterButtonFactory.button(with: rightButtonModel, action: rightButtonAction)
        }
    }
}
