//
//  RatingButtonsViewModel.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 8/14/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import Combine
import SwiftUI

final class RatingsButtonViewModel {
    var thumbsUpFont: Font
    var thumbsDownFont: Font
    
    private var currentRating: Rating
    
    private let selectedFont: Font = .appFont(size: 69)
    private let unselectedFont: Font = .appFont(size: 42)
    
    init(currentRating: Rating) {
        self.currentRating = currentRating
        
        switch currentRating {
        case .unrated:
            thumbsUpFont = unselectedFont
            thumbsDownFont = unselectedFont
        case .thumbsDown:
            thumbsUpFont = unselectedFont
            thumbsDownFont = selectedFont
        case .thumbsUp:
            thumbsUpFont = selectedFont
            thumbsDownFont = unselectedFont
        }
    }

}
