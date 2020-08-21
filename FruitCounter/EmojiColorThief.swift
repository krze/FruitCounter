//
//  EmojiColorThief.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 8/21/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import ColorThiefSwift
import Foundation

struct EmojiColorThief {
    
    static func getPalette(from emoji: String) -> [UIColor] {
        guard let image = emoji.image() else { return defaultPalette() }
        return ColorThief.getPalette(from: image, colorCount: 3)?.compactMap({ color -> UIColor in
            return color.makeUIColor()
        }) ?? defaultPalette()
    }
    
    static func defaultPalette() -> [UIColor] {
        [UIColor(red:1.00, green:0.60, blue:0.83, alpha:1.0),
         UIColor(red:0.00, green:0.36, blue:0.30, alpha:1.0),
         UIColor(red:0.21, green:0.20, blue:0.22, alpha:1.0)
        ]
    }
}

extension String {
    func image() -> UIImage? {
        let size = CGSize(width: 40, height: 40)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.white.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: 40)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
