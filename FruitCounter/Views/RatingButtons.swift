//
//  RatingButtons.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 8/14/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import SwiftUI

struct RatingButtons: View {
    @Binding var rating: Rating
    @ObservedObject var viewModel: RatingsButtonViewModel
    
    var body: some View {
        HStack(spacing: 20) {
            Button(action: { self.rating = .thumbsDown }) {
                Text(Rating.thumbsDown.emoji).font(viewModel.thumbsDownFont)
            }
            Button(action: { self.rating = .thumbsUp }) {
                Text(Rating.thumbsUp.emoji).font(viewModel.thumbsUpFont)
            }
        }.animation(.easeInOut)
    }
}

struct RatingButtons_Previews: PreviewProvider {
    @State static var rating: Rating = .unrated
    static var previews: some View {
        let viewModel = RatingsButtonViewModel(currentRating: .unrated)
        return RatingButtons(rating: $rating, viewModel: viewModel)
    }
}
