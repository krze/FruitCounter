//
//  Rating.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 7/3/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import Foundation

enum Rating: Int, Codable {
    
    case unrated, thumbsDown, thumbsUp
    
    var emoji: String {
        switch self {
        case .thumbsUp: return "👍"
        case .thumbsDown: return "👎"
        case .unrated: return "❓"
        }
    }
}
