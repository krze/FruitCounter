//
//  FruitLogListView.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 7/17/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import SwiftUI

struct FruitLogListView: View {
    
    @ObservedObject var viewModel: FruitLogListViewModel
    @State private var presentSheet = false
    
    var body: some View {
        List {
            ForEach(viewModel.latestLogs(), id: \.hashValue) { fruitLog in
                FruitLogView(viewModel: self.viewModel.fruitLogViewModel(from: fruitLog))
            }
        }
        .cornerRadius(30.0)
        .padding(30)
    }
}

struct FruitLogListView_Previews: PreviewProvider {
    static var previews: some View {
        let testLogbook = LogBook(userName: "Default Username", logs: [], focusedFruit: .watermelon)
        let logCoordinator = LogCoordinator(logBook: testLogbook, dataCoordinator: DataCoordinator())
        let viewModel = FruitLogListViewModel(logCoordinator: logCoordinator, fruit: .watermelon, font: .appFont(size: 24.0))
        return FruitLogListView(viewModel: viewModel)
    }
}
