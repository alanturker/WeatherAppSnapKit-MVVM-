//
//  KF + UIImageView.swift
//  WeatherAppSnapKit
//
//  Created by admin on 12.01.2022.
//

import Foundation
import Kingfisher

extension UIImageView {
    func setImage(from urlString: String) {
        if let url = URL(string:urlString) {
            self.kf.setImage(with: url)
        }
        
    }
}



































