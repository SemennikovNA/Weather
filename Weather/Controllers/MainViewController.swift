//
//  MainViewController.swift
//  Weather
//
//  Created by Nikita on 09.12.2023.
//

import UIKit
import CoreLocation
import Network

class MainViewController: UIViewController {
    
    //MARK: - UI Elements
    
    private lazy var mainView = MainView()
    private lazy var hourWeather = HourlyWeatherCollection()
    private lazy var daysWeather = DaysWeatherTable()
    
    //MARK: - Properties
    
    let locationManager = CLLocationManager()
    let weatherRequestManager = WeatherManager()
    let hourWeatherInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    var hourlyForecastData: [HourlyForecast] {
        didSet {
            DispatchQueue.main.async {
                self.hourWeather.reloadData()
            }
        }
    }
    var dayliForecastData: [DailyWeather] {
        didSet {
            DispatchQueue.main.async {
                self.daysWeather.reloadData()
            }
        }
    }
    
    //MARK: - Initialize
    
    init() {
        self.hourlyForecastData = []
        self.dayliForecastData = []
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call fucntion's
        setupView()
        signatureDelegate()
        requestUserLocation()
        setupConstraints()
    }
    
    //MARK: - Private methods
    
    private func signatureDelegate() {
        // Delegates and data source
        mainView.searchTextField.delegate = self
        daysWeather.dataSource = self
        daysWeather.delegate = self
        hourWeather.delegate = self
        hourWeather.dataSource = self
        locationManager.delegate = self
        weatherRequestManager.delegate = self
    }
    
    private func setupView() {
        // Setup view
        view.addSubviews(mainView, hourWeather, daysWeather)
        view.backgroundColor = .back
        
        // Setup main view
        mainView.backgroundColor = .back
        
        // Days weather table
        daysWeather.showsVerticalScrollIndicator = false
        
        // Hour weather collection
        hourWeather.showsHorizontalScrollIndicator = false
        hourWeather.backgroundColor = .back
        hourWeather.contentInset = UIEdgeInsets(top: hourWeatherInsets.top, left: hourWeatherInsets.left, bottom: hourWeatherInsets.bottom, right: hourWeatherInsets.right)
        
        // Add targets for button
        mainView.locationButtonAddTarget(target: self, selector: #selector(locationButtonTapped))
        mainView.searchButtonAddTarget(target: self, selector: #selector(searchButtonTapped))
    }
    
    private func requestUserLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    private func searchTapped() {
        guard let city = mainView.searchTextField.text else { return }
        weatherRequestManager.getURLForCity(city: city)
    }
    
    //MARK: - Objectiv-C methods
    
    @objc func locationButtonTapped() {
        locationManager.requestLocation()
        guard let latitude = locationManager.location?.coordinate.latitude, let longitude = locationManager.location?.coordinate.longitude else { return }
        weatherRequestManager.getCoordinate(lat: latitude, lon: longitude)
    }
    
    @objc func searchButtonTapped() {
        mainView.searchTextField.endEditing(true)
        searchTapped()
    }
    
}

//MARK: - Extension

//MARK: Collection view delegate, data source and flow layout methods

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyForecastData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = hourWeather.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.reuseID, for: indexPath) as! CustomCollectionViewCell
        let hourForecast = hourlyForecastData[indexPath.item]
        cell.configure(with: hourForecast)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionCellSize = CGSize(width: 50, height: 100)
        return collectionCellSize
    }
}

//MARK: Table view delegate, data source methods

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayliForecastData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = daysWeather.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseIdentifier, for: indexPath) as! CustomTableViewCell
        let dayForecast = dayliForecastData[indexPath.item]
        cell.configure(with: dayForecast)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heightForRowTable: CGFloat = 60
        return heightForRowTable
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let heightForHeader: CGFloat = 20
        return heightForHeader
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dayCount = dayliForecastData.count
        let headerText = "Прогноз на \(dayCount) дней"
        return headerText
    }
}

//MARK: Text field delegate

extension MainViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = mainView.searchTextField.text else { return }
        print(text)
        mainView.searchTextField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTapped()
        mainView.searchTextField.endEditing(true)
        return true
    }
}

//MARK: Core location delegate

extension MainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let _ = location.coordinate.latitude
        let _ = location.coordinate.longitude
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension MainViewController: WeatherDelegate {
    
    func updateHourlyForecast(_ hourlyForecast: [HourlyForecast]?) {
        guard let hourlyForecastData = hourlyForecast else { return }
        self.hourlyForecastData = hourlyForecastData
        DispatchQueue.main.async {
            self.hourWeather.reloadData()
        }
    }
    
    func updateDayliForecast(_ dayliForecast: [DailyWeather]?) {
        guard let dayliForecastData = dayliForecast else { return }
        self.dayliForecastData = dayliForecastData
        DispatchQueue.main.async {
            self.daysWeather.reloadData()
        }
    }
    
    //MARK: Weather delegate methods
    
    func didUpdateAdvancedWeather(_ weatherManager: WeatherManager, dailyForecast weather: [DailyWeather]?, hourlyForecast: [HourlyForecast]?) {
        guard let hourlyForecastDatas = hourlyForecast, let dailyForecastDatas = weather else { return }
        updateHourlyForecast(hourlyForecastDatas)
        updateDayliForecast(dailyForecastDatas)
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.mainView.cityLabel.text = weather.city
            self.mainView.temperatureLabel.text = weather.temperatureString
            self.mainView.descriptionWeatherLabel.text = weather.description
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

//MARK: Constraints for view

extension MainViewController {
    
    /// Value for constants
    private enum Constants {
        static let tenPoints: CGFloat = 10
        static let twentyPoints: CGFloat = 20
        static let thertyPoints: CGFloat = 20
        static let hourWeatherHeight: CGFloat = 100
        static let mainViewHeight: CGFloat = 280
        static let hourWeatherTopIdent: CGFloat = 280
    }
    
    /// Setup constraints for user elements
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            // Main view
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.heightAnchor.constraint(equalToConstant: Constants.mainViewHeight),
            
            // Hour weather collection
            hourWeather.topAnchor.constraint(equalTo: mainView.bottomAnchor),
            hourWeather.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.twentyPoints),
            hourWeather.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.twentyPoints),
            hourWeather.heightAnchor.constraint(equalToConstant: Constants.hourWeatherHeight),
            
            // Days table
            daysWeather.topAnchor.constraint(equalTo: hourWeather.bottomAnchor),
            daysWeather.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.twentyPoints),
            daysWeather.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.twentyPoints),
            daysWeather.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
