//
//  Date+LocalizedShort.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 8/14/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import Foundation

extension Date {
    
    func localizedDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
    
}
