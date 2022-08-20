//
//  ViewController.swift
//  Bankey
//
//  Created by srinivas on 19/08/22.
//

import Foundation
import UIKit

struct Weather {
    let city: String
    let tmp: String
    let image: String
}

protocol WeatherServiceDelegate: AnyObject {
    func didFetchWeather(_ weather: Weather)
}

protocol WeatherServiceDataSource: AnyObject {
    var city: String? { get }
}

class WeatherService {
    
    weak var delegate: WeatherServiceDelegate?
    weak var dataSource: WeatherServiceDataSource?
    
    func fetchWeather() {
        
        guard let dataSource = dataSource, let city = dataSource.city else {
            fatalError("data source not set")
        }
        
        let weather = Weather(city: city, tmp: "19c", image: "sunset.fill")
        delegate?.didFetchWeather(weather)
    }
    
    
}


class ViewController: UIViewController {
    
    let weatherService = WeatherService()
    let stackView = UIStackView()
    let cityLabel = UILabel()
    let tmpLabel = UILabel()
    let weatherImage = UIImageView()
    
    let fetchButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherService.delegate = self
        weatherService.dataSource = self
        setupViews()
    }
    
    func setupViews() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        tmpLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        
        fetchButton.translatesAutoresizingMaskIntoConstraints = false
        
        cityLabel.text = "Hyderabad"
        cityLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        cityLabel.numberOfLines = 0
        
        tmpLabel.text = "32c"
        tmpLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        weatherImage.image = UIImage(systemName: "sunset.fill", withConfiguration: configuration)
        
        fetchButton.setTitle("Fetch Weather", for: [])
        fetchButton.configuration = .filled()
        fetchButton.addTarget(self, action: #selector(fetchTapped), for: .primaryActionTriggered)
      
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        
        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(tmpLabel)
        stackView.addArrangedSubview(weatherImage)
        
        view.addSubview(stackView)
        view.addSubview(fetchButton)
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 50),
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
//            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            fetchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fetchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    
    @objc func fetchTapped(_ sender: UIButton) {
        weatherService.fetchWeather()
    }
}

// MARK: - Delegate
extension ViewController: WeatherServiceDelegate {
    
    func didFetchWeather(_ weather: Weather) {
        
        cityLabel.text = weather.city
        tmpLabel.text = weather.tmp
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        weatherImage.image = UIImage(systemName: weather.image, withConfiguration: configuration)
    }
    
}
//MARK: - DataSource
extension ViewController: WeatherServiceDataSource {
    
    var city: String? {
        return "Austrelia"
    }
}
