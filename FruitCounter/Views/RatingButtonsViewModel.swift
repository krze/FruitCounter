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
    let font: Font = .appFont(size: 69)
    var thumbsUpOpacity: Double
    var thumbsDownOpacity: Double
    
    private var currentRating: Rating
    
    private let selectedOpacity: Double = 1
    private let unselectedOpacity: Double = 0.35
    
    init(currentRating: Rating) {
        self.currentRating = currentRating
        
        switch currentRating {
        case .unrated:
            thumbsUpOpacity = unselectedOpacity
            thumbsDownOpacity = unselectedOpacity
        case .thumbsDown:
            thumbsUpOpacity = unselectedOpacity
            thumbsDownOpacity = selectedOpacity
        case .thumbsUp:
            thumbsUpOpacity = selectedOpacity
            thumbsDownOpacity = unselectedOpacity
        }
    }

}
