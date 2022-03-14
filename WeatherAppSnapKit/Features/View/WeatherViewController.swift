//
//  ViewController.swift
//  WeatherAppSnapKit
//
//  Created by admin on 12.01.2022.
//

import UIKit
import SwiftUI
import SnapKit
import CoreLocation
import CoreMIDI

protocol WeatherViewControllerOutputProtocol {
    func getHourlyWeather(results: HourlyWeatherModel)
    func getWeeklyWeather(results: WeeklyWeatherModel)
    func getCurrentWeather(results: CurrentWeatherModel)
}

final class WeatherViewController: UIViewController {
    
    fileprivate struct WeatherViewConstants {
        static let textColor = Styling.giveColorOf(.white)
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Weather DB"
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = WeatherViewConstants.textColor
        label.font = Styling.giveFont(fontName: .pro, size: 30)
        return label
    }()
    
    private lazy var titleView: UIView = {
        let view = UIView()
        view.backgroundColor = Styling.giveColorOf(.darkGreen)
        return view
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search for a City"
        return searchBar
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Istanbul"
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = Styling.giveColorOf(.white)
        label.font = Styling.giveFont(fontName: .pro, size: 25)
        return label
    }()
    
    private lazy var degreeLabel: UILabel = {
        let label = UILabel()
        label.text = "20°"
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = Styling.giveColorOf(.white)
        label.font = Styling.giveFont(fontName: .altarnate, size: 60)
        return label
    }()
    
    private lazy var weatherIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "sun.max")
        imageView.tintColor = Styling.giveColorOf(.black)
        return imageView
    }()
    
    private lazy var iconsView: UIView = {
        let view = UIView()
        view.backgroundColor = Styling.giveColorOf(.darkGreen)
        return view
    }()
    
    private lazy var windImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "windIcon")
        imageView.tintColor = Styling.giveColorOf(.black)
        return imageView
    }()
    
    private lazy var windLabel: UILabel = {
        let label = UILabel()
        label.text = "2"
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = Styling.giveColorOf(.white)
        label.font = Styling.giveFont(fontName: .altarnate, size: 14)
        return label
    }()
    
    private lazy var rainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rainChanceIcon")
        imageView.tintColor = Styling.giveColorOf(.black)
        return imageView
    }()
    
    private lazy var rainLabel: UILabel = {
        let label = UILabel()
        label.text = "2"
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = Styling.giveColorOf(.white)
        label.font = Styling.giveFont(fontName: .altarnate, size: 14)
        return label
    }()
    
    private lazy var humidityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "humidityIcon")
        imageView.tintColor = Styling.giveColorOf(.black)
        return imageView
    }()
    
    private lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.text = "2"
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = Styling.giveColorOf(.white)
        label.font = Styling.giveFont(fontName: .altarnate, size: 14)
        return label
    }()
    
    private lazy var hourlyWeatherCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.register(HourlyWeatherCollectionViewCell.self, forCellWithReuseIdentifier: HourlyWeatherCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.bounces = false
        return collectionView
    }()
    
    private lazy var weeklyWeatherCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        collectionView.register(WeeklyWeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeeklyWeatherCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = Styling.giveColorOf(.white)
        collectionView.bounces = false
        return collectionView
    }()
    
    private lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a"
        return formatter
    }()
    
    private var currentWeather = CurrentWeatherModel()
    private var hourlyWeather = HourlyWeatherModel()
    private var weeklyWeather = WeeklyWeatherModel()
    private var cityView = CityViewViewModel()
    private var cityCoordinate: CLLocationCoordinate2D?
    
    private lazy var searchedCityName: String = "London" {
        didSet {
            getLocation(city: searchedCityName)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityView.setDelegates(output: self)
        getLocation(city: searchedCityName)
        DispatchQueue.main.async { [weak self] in
            self?.cityView.fetchCurrentWeather(lat: self?.cityCoordinate?.latitude ?? 41.0 , lon: self?.cityCoordinate?.longitude ?? 28.9)
            self?.cityView.fetchHourlyWeather(lat: self?.cityCoordinate?.latitude ?? 41.0, lon: self?.cityCoordinate?.longitude ?? 28.9)
            self?.cityView.fetchWeeklyWeather(lat: self?.cityCoordinate?.latitude ?? 41.0, lon: self?.cityCoordinate?.longitude ?? 28.9)
        }
        configureUI()
        setComponents()
    }
    
    private func configureUI() {
        view.backgroundColor = Styling.giveColorOf(.darkGreen)
        // addSubbviews
        view.addSubviews(titleView, searchBar, cityLabel, degreeLabel, weatherIconView, iconsView, hourlyWeatherCollectionView, weeklyWeatherCollectionView)
        titleView.addSubview(titleLabel)
        iconsView.addSubviews(windImageView, rainImageView, humidityImageView, windLabel, rainLabel, humidityLabel)
        
        // UI Constraint Setting
        setConstraintsUI()
        
    }
    
    
}

//MARK: - UISearchBar Delegate Methods
extension WeatherViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        searchedCityName = searchText
//    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchedCityName = searchBar.text ?? ""
        cityView.fetchCurrentWeather(lat: cityCoordinate?.latitude ?? 41.0, lon: cityCoordinate?.longitude ?? 28.9)
        cityView.fetchHourlyWeather(lat: cityCoordinate?.latitude ?? 41.0, lon: cityCoordinate?.longitude ?? 28.9)
        cityView.fetchWeeklyWeather(lat: cityCoordinate?.latitude ?? 41.0, lon: cityCoordinate?.longitude ?? 28.9)
        
    }
}
//MARK: - Change City Name to Coordinate
extension WeatherViewController {
    func getLocation(city: String) {
        CLGeocoder().geocodeAddressString(city) { (placemarks, error) in
            if let places = placemarks, let place = places.first {
                self.cityCoordinate = place.location?.coordinate
            }
        }
    }
}

//MARK: -UIComponents Constraints
extension WeatherViewController {
    private func setConstraintsUI() {
        titleView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(40)
            make.right.left.equalToSuperview()
            make.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleView.snp.top).offset(10)
            make.right.left.equalTo(self.titleView)
            make.height.equalTo(30)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.titleView.snp.bottom).offset(10)
            make.left.equalTo(view).offset(12)
            make.right.equalTo(view).offset(-12)
            make.height.equalTo(30)
        }
        
        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(self.searchBar.snp.bottom).offset(20)
            make.left.equalTo(view).offset(12)
            make.right.equalTo(view).offset(-12)
            make.height.equalTo(30)
        }
        
        degreeLabel.snp.makeConstraints { make in
            make.top.equalTo(self.cityLabel.snp.bottom).offset(20)
            make.centerX.equalTo(self.cityLabel.snp.centerX).offset(-60)
            make.height.equalTo(70)
        }
        
        weatherIconView.snp.makeConstraints { make in
            make.top.equalTo(self.cityLabel.snp.bottom).offset(20)
            make.centerX.equalTo(self.cityLabel.snp.centerX).offset(60)
            make.height.equalTo(70)
            make.width.equalTo(70)
        }
        
        iconsView.snp.makeConstraints { make in
            make.top.equalTo(self.degreeLabel.snp.bottom).offset(40)
            make.right.left.equalToSuperview()
            make.height.equalTo(40)
        }
        
        windImageView.snp.makeConstraints { make in
            make.top.equalTo(self.iconsView.snp.top)
            make.left.equalTo(view).offset(100)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        windLabel.snp.makeConstraints { make in
            make.top.equalTo(self.windImageView.snp.bottom).offset(6)
            make.centerX.equalTo(self.windImageView.snp.centerX)
            make.width.equalTo(40)
            make.height.equalTo(20)
        }
        
        rainImageView.snp.makeConstraints { make in
            make.top.equalTo(self.iconsView.snp.top)
            make.right.equalTo(view).offset(-100)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        rainLabel.snp.makeConstraints { make in
            make.top.equalTo(self.rainImageView.snp.bottom).offset(6)
            make.centerX.equalTo(self.rainImageView.snp.centerX)
            make.width.equalTo(40)
            make.height.equalTo(20)
        }
        
        humidityImageView.snp.makeConstraints { make in
            make.top.equalTo(self.iconsView.snp.top)
            make.centerX.equalTo(self.iconsView.snp.centerX)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        humidityLabel.snp.makeConstraints { make in
            make.top.equalTo(self.humidityImageView.snp.bottom).offset(6)
            make.centerX.equalTo(self.humidityImageView.snp.centerX)
            make.width.equalTo(40)
            make.height.equalTo(20)
        }
        
        hourlyWeatherCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.rainLabel.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(180)
        }
    }
}
//MARK: - Set UI Components Methods
extension WeatherViewController {
    func setComponents() {
        
        
    }
}

extension WeatherViewController {
    func makeIcon(id: Int) -> String {
            switch id {
            case 200...232:
                return "cloud.bolt.rain"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.heavyrain"
            case 600...622:
                return "cloud.snow"
            case 701...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            case 801...804:
                return "cloud"
            default:
                break
            }
        return "sun.max"
    }
}
//MARK: - WeatherViewController Output Methods
extension WeatherViewController: WeatherViewControllerOutputProtocol {
    func getHourlyWeather(results: HourlyWeatherModel) {
        hourlyWeather.hourly = results.hourly
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.hourlyWeatherCollectionView.reloadData()
        }
    }
    
    func getWeeklyWeather(results: WeeklyWeatherModel) {
        weeklyWeather.daily = results.daily
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.weeklyWeatherCollectionView.reloadData()
        }
    }
    
    func getCurrentWeather(results: CurrentWeatherModel) {
        cityLabel.text = searchedCityName
        currentWeather.current = results.current
        degreeLabel.text = String(format: "%.1f", results.current?.temperature ?? 0.0)
        windLabel.text = String(format: "%.1f", results.current?.windSpeed ?? "")
        rainLabel.text = String(format: "%.1f%%", results.current?.dew_point ?? 0)
        humidityLabel.text = String(format: "%.1d%%", results.current?.humidity ?? 0)
        
        let id = results.current?.weather?[0].id ?? 800

        weatherIconView.image = UIImage(systemName: makeIcon(id: id))
        
        
    }
    
    
}
//MARK: - UICollectionView Delegate & DataSource Methods
extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView == weeklyWeatherCollectionView ? 8 : 23
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case hourlyWeatherCollectionView:
            guard let cell = hourlyWeatherCollectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCollectionViewCell.identifier, for: indexPath) as? HourlyWeatherCollectionViewCell else { return UICollectionViewCell() }
            cell.setWeather(hourLabelText: timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(hourlyWeather.hourly?[indexPath.item].date ?? 0))),
                            imageName: makeIcon(id: hourlyWeather.hourly?[indexPath.item].weather?[0].id ?? 800),
                            degreeLabelText: String(format: "%.1f", hourlyWeather.hourly?[indexPath.item].temperature ?? 0.0))
            return cell
        case weeklyWeatherCollectionView:
            guard let cell2 = weeklyWeatherCollectionView.dequeueReusableCell(withReuseIdentifier: WeeklyWeatherCollectionViewCell.identifier, for: indexPath) as? WeeklyWeatherCollectionViewCell else { return UICollectionViewCell() }
            return cell2
        default:
            //no-op
            break
        }
        return UICollectionViewCell()
    }
}
//MARK: - UICollectionView FlowLayoutDelegate Methods
extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        K.cellSizeForItemAt
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        K.cellInsetForSectionAt
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        K.cellMinimumLineSpacing
    }
}
