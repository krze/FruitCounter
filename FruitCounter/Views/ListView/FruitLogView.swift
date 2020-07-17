//
//  FruitLogView.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 7/17/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import SwiftUI

struct FruitLogView: View {
    let fruitEmoji: String
    let date: Date
    let rating: Rating
    let font: Font
    
    var body: some View {
        HStack {
            Spacer()
            Text(fruitEmoji).font(self.font).padding()
            Text(localizedDateString(from: date)).font(self.font)
            Text(rating.emoji).padding() // TODO: Long-press gesture to open quick rating wheel
            Spacer()
        }.onTapGesture {
            // TODO: respond to tap opening editor
            print("Tapped \(self.fruitEmoji) \(self.localizedDateString(from: self.date))!")
        }
    }
    
    private func localizedDateString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct FruitLogView_Previews: PreviewProvider {
    static var previews: some View {
        FruitLogView(fruitEmoji: "🍉", date: Date(), rating: .thumbsUp, font: .appFont(size: 12))
    }
}
