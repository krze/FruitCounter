//
//  MainView.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 7/24/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @GestureState private var dragOffset: CGSize = .zero
    @State private var bottomViewHeight: CGFloat = .zero
    @State private var topViewHeight: CGFloat = .infinity
    @State private var presentDetail: FruitLogViewModel?
    @State private var blurRadius: CGFloat = .zero
    
    // How far the user drags before the view will snap
    private let snapTolerance: CGFloat = 50.0
    
    let maxBottomViewRatio: CGFloat
    var maxTopViewRatio: CGFloat {
        return 1 - maxBottomViewRatio
    }
    
    @ObservedObject var counterViewModel: CounterViewModel
    let listViewModel: FruitLogListViewModel
    
    private var Content: some View {
        GeometryReader { geometry in
            ZStack {
                Color(self.counterViewModel.palette.primary).edgesIgnoringSafeArea(.all)
                VStack {
                    CounterView(viewModel: self.counterViewModel)
                        .animation(.easeInOut)
                        .frame(minWidth: 0,
                               maxWidth: .infinity,
                               minHeight: 0,
                               maxHeight: self.dragOffset.height + self.topViewHeight)
                        .background(Color(self.counterViewModel.palette.primary))
                        .gesture(
                            DragGesture()
                                .updating(self.$dragOffset, body: { (value, state, transaction) in
                                state = value.translation
                               })
                               .onEnded({ (value) in
                                self.snapViews(withTranslationHeight: -value.translation.height, geomoetry: geometry)
                               })
                    )
                    
                    FruitLogListView(viewModel: self.listViewModel, presentDetail: self.$presentDetail, backgroundColor: self.counterViewModel.palette.primary)
                        .animation(.easeInOut)
                        .frame(minWidth: 0,
                               maxWidth: .infinity,
                               minHeight: 0,
                               maxHeight: -self.dragOffset.height + self.bottomViewHeight)
                }
                .background(Color(self.counterViewModel.palette.primary))
                .blur(radius: self.blurRadius)
                .allowsHitTesting(self.blurRadius == .zero)
                
                if self.presentDetail != nil {
                    ZStack {
                        Color.black.opacity(0.1)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                withAnimation {
                                    self.presentDetail = nil
                                    self.blurRadius = .zero
                                }
                        }
                        
                        DetailView(fruitLogViewModel: self.presentDetail!, mutableFruitLog: self.presentDetail!.fruitLog.getMutableFruitLog(), deletionCallback: self.dismissDetail)
                            .padding(25)
                            .background(Color(self.counterViewModel.palette.primary))
                            .cornerRadius(10)
                            .onAppear {
                                self.blurRadius = 5
                            }

                    }.animation(.easeInOut)
                }

            }
            
        }
    }
    
    var body: some View {
        Content
            .animation(.easeInOut)
    }
    
    private func snapViews(withTranslationHeight translationHeight: CGFloat, geomoetry: GeometryProxy) {
        let direction = translationHeight > 0 ? Direction.up : Direction.down
        let shouldReset = direction == .up ? (translationHeight < snapTolerance) : abs(translationHeight) > snapTolerance
        
        if shouldReset {
            bottomViewHeight = .zero
            topViewHeight = .infinity
        }
        else {
            bottomViewHeight = geomoetry.size.height * maxBottomViewRatio
            topViewHeight = geomoetry.size.height * maxTopViewRatio
        }
    }
    
    private func dismissDetail() {
        self.presentDetail = nil
        self.blurRadius = 0
    }
    
    private enum Direction {
        case up, down
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let logBook = LogBook(userName: "Default", logs: [FruitLog(fruit: .watermelon, dateConsumed: Date())], focusedFruit: .watermelon)
        let logCoordinator = LogCoordinator(logBook: logBook, dataCoordinator: DataCoordinator())
        let counterViewModel = CounterViewModel(logCoordinator: logCoordinator, font: .appBoldFont(size: 69.0))
        
        let fruitListVM = FruitLogListViewModel(logCoordinator: logCoordinator, fruit: .watermelon, font: .appFont(size: 18.0))

        return MainView(maxBottomViewRatio: 0.5, counterViewModel: counterViewModel, listViewModel: fruitListVM)
    }
}

