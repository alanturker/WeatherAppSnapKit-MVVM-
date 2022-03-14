//
//  HourlyWeatherCell.swift
//  WeatherAppSnapKit
//
//  Created by admin on 18.01.2022.
//

import Foundation
import UIKit
import SnapKit

class HourlyWeatherCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "HourlyCell"
    
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
    
    private lazy var hourLabel: UILabel = {
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
    
    private lazy var degreeTextLabel: UILabel = {
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
    
    func setWeather(hourLabelText: String, imageName: String, degreeLabelText: String ) {
        hourLabel.text = hourLabelText
        weatherIconView.image = UIImage(systemName: imageName)
        degreeTextLabel.text = degreeLabelText
    }
}
//MARK: - Cell Components Constraints
extension HourlyWeatherCollectionViewCell {
    private func setComponentsConstraintsUI() {
        addSubview(containerView)
        containerView.addSubviews(hourLabel,weatherIconView,degreeTextLabel)
        
        contentView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalTo(contentView)
        }
        
        hourLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(20)
            make.left.equalTo(containerView.snp.left).offset(1)
            make.right.equalTo(containerView.snp.right).offset(-1)
            make.height.equalTo(30)
        }
        
        weatherIconView.snp.makeConstraints { make in
            make.centerY.equalTo(containerView.snp.centerY)
            make.centerX.equalTo(containerView.snp.centerX)
            make.height.width.equalTo(20)
        }
        
        degreeTextLabel.snp.makeConstraints { make in
            make.bottom.equalTo(containerView.snp.bottom).offset(-20)
            make.left.equalTo(containerView.snp.left).offset(1)
            make.right.equalTo(containerView.snp.right).offset(-1)
            make.height.equalTo(30)
        }
        
    }
}
