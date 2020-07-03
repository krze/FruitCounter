//
//  Font+AppStyle.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 7/3/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import SwiftUI

extension Font {
    
    static func appFont(size: CGFloat) -> Font {
        Font.custom("AmericanTypewriter", size: size)
    }
    
    static func appBoldFont(size: CGFloat) -> Font {
        Font.custom("AmericanTypewriter-Bold", size: size)
    }
    
}
