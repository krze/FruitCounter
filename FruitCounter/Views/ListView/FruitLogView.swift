//
//  FruitLogView.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 7/17/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import SwiftUI

struct FruitLogView: View {
    
    let viewModel: FruitLogViewModel
    @Binding var presentDetail: FruitLogViewModel?
    
    var body: some View {
        HStack {
            Spacer()
            Text(viewModel.fruitLog.fruit.emoji).font(viewModel.font).padding()
            Text( viewModel.fruitLog.dateConsumed.localizedDateString()).font(viewModel.font)
            Text(viewModel.fruitLog.rating.emoji).padding() // TODO: Long-press gesture to open quick rating wheel
        }.onTapGesture {
            self.presentDetail = self.viewModel
        }
    }
}
