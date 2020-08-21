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
    @Binding var presentDetail: FruitLogViewModel?
    let backgroundColor: UIColor
    
    var body: some View {
        List {
            ForEach(viewModel.latestLogs(), id: \.hashValue) { fruitLog in
                FruitLogView(viewModel: self.viewModel.fruitLogViewModel(from: fruitLog), presentDetail: self.$presentDetail)
            }
        }
        .cornerRadius(30.0)
        .padding(30)
        .background(Color(backgroundColor))
        .edgesIgnoringSafeArea(.all)
    }

}

struct FruitLogListView_Previews: PreviewProvider {
    @State static var presentDetailView: FruitLogViewModel?
    static var previews: some View {
        let testLogbook = LogBook(userName: "Default Username", logs: [], focusedFruit: .watermelon)
        let logCoordinator = LogCoordinator(logBook: testLogbook, dataCoordinator: DataCoordinator())
        let viewModel = FruitLogListViewModel(logCoordinator: logCoordinator, fruit: .watermelon, font: .appFont(size: 24.0))
        return FruitLogListView(viewModel: viewModel, presentDetail: $presentDetailView, backgroundColor: .blue)
    }
}
