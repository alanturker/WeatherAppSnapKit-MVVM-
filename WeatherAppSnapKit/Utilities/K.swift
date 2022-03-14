//
//  K.swift
//  WeatherAppSnapKit
//
//  Created by admin on 23.01.2022.
//

import UIKit

struct K {
    
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    //MARK: - CollectionView Ks
    static let cellMinimumLineSpacing: CGFloat = 10
    static let cellInsetForSectionAt: UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    static let cellSizeForItemAt: CGSize = CGSize(width: screenWidth / 3 - 25, height: screenHeight * 0.2)
    
}
