//
//  Styling.swift
//  WeatherAppSnapKit
//
//  Created by admin on 17.01.2022.
//

import Foundation
import UIKit

struct Styling {
    
    enum FontsName: String {
        case altarnate = "DIN Alternate Bold"
        case pro = "Geeza Pro Bold"
    }
    
    static func giveFont(fontName: FontsName, size: Float) -> UIFont {
        if let font = UIFont.init(name: "\(fontName.rawValue.capitalized)", size: CGFloat(size)) {
            return font
        } else {
            return UIFont.systemFont(ofSize: CGFloat(size))
        }
    }
    
    enum Colors {
        case black
        case purple
        case darkGreen
        case white
        case darkPurple
    }
    
    static func giveColorOf(_ color: Colors) -> UIColor {
        switch color {
        case .black:
            return UIColor.colorFromRGB(r: 0, g: 0, b: 0)
        case .purple:
            return UIColor.colorFromRGB(r: 112, g: 11, b: 151)
        case .darkGreen:
            return UIColor.colorFromRGB(r: 97, g: 111, b: 57)
        case .white:
            return UIColor.colorFromRGB(r: 216, g: 233, b: 168)
        case .darkPurple:
            return UIColor.colorFromRGB(r: 62, g: 6, b: 95)
        }
    }
    
}

