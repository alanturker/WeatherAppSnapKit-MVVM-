//
//  WeeklyWeatherCell.swift
//  WeatherAppSnapKit
//
//  Created by admin on 18.01.2022.
//

import Foundation
import UIKit

class WeeklyWeatherCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "WeeklyCell"
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1.2
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.1
        return view
    }()
    
    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.text = "11 am"
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = Styling.giveColorOf(.white)
        label.font = Styling.giveFont(fontName: .altarnate, size: 14)
        return label
    }()
    
    private lazy var weatherIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sun.max")
        imageView.tintColor = Styling.giveColorOf(.black)
        return imageView
    }()
    
    private lazy var minDegreeTextLabel: UILabel = {
        let label = UILabel()
        label.text = "20°"
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = Styling.giveColorOf(.white)
        label.font = Styling.giveFont(fontName: .altarnate, size: 14)
        return label
    }()
    
    private lazy var maxDegreeTextLabel: UILabel = {
        let label = UILabel()
        label.text = "20°"
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = Styling.giveColorOf(.white)
        label.font = Styling.giveFont(fontName: .altarnate, size: 14)
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setComponentsConstraintsUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setComponentsConstraintsUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeeklyWeatherCollectionViewCell {
    func setComponentsConstraintsUI() {
        
    }
}
