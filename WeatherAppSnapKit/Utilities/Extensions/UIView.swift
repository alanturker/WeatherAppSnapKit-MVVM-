//
//  UIView.swift
//  WeatherAppSnapKit
//
//  Created by admin on 18.01.2022.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({addSubview($0)})
    }
}
