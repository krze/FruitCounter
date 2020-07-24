//
//  SnappingTwoPaneView.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 7/17/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import SwiftUI

struct SnappingTwoPaneView<TopView: View, BottomView: View>: View {
    
    @GestureState private var dragOffset: CGSize = .zero
    @State private var bottomViewHeight: CGFloat = .zero
    @State private var topViewHeight: CGFloat = .infinity
    
    let topView: TopView
    let bottomView: BottomView
    
    let snapTolerance: CGFloat
    let maxBottomViewRatio: CGFloat
    var maxTopViewRatio: CGFloat {
        return 1 - maxBottomViewRatio
    }
    
    private var Content: some View {
        VStack {
        self.topView
            .animation(.easeInOut)
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   minHeight: 0,
                   maxHeight: self.dragOffset.height + self.topViewHeight)
        self.bottomView
            .animation(.easeInOut)
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   minHeight: 0,
                   maxHeight: -self.dragOffset.height + self.bottomViewHeight)
            .background(Color.red)
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.Content
                .gesture(
                    DragGesture()
                        .updating(self.$dragOffset, body: { (value, state, transaction) in
                        state = value.translation
                       })
                       .onEnded({ (value) in
                        self.snapViews(withTranslationHeight: -value.translation.height, geomoetry: geometry)
                       })
            )
            
        }.animation(.easeInOut)
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
    
    private enum Direction {
        case up, down
    }
}

struct SnappingTwoPaneView_Previews: PreviewProvider {
    static var previews: some View {
        let logBook = LogBook(userName: "Default", logs: [FruitLog(fruit: .watermelon, dateConsumed: Date())], focusedFruit: .watermelon)
        let logCoordinator = LogCoordinator(logBook: logBook, dataCoordinator: DataCoordinator())
        let counterViewModel = CounterViewModel(logCoordinator: logCoordinator, font: .appFont(size: 69.0))
        let counterView = CounterView(viewModel: counterViewModel)
        let bottomView = Text("SHITE")
        return SnappingTwoPaneView(topView: counterView, bottomView: bottomView, snapTolerance: 200.0, maxBottomViewRatio: 0.7)
    }
}
