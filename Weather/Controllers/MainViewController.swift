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
    private lazy var connectedLabel = UILabel(textAlignment: .center)
    
    //MARK: - Properties
    
    let locationManager = CLLocationManager()
    let weatherRequestManager = WeatherManager()
    let hourWeatherInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    let weekDay = [
        Week(day: "Sunday"),
        Week(day: "Monday"),
        Week(day: "Tuesday"),
        Week(day: "Wednesday"),
        Week(day: "Thursday"),
        Week(day: "Friday"),
        Week(day: "Saturday")
    ]
    var hourlyForecastData: [HourlyForecast] {
            didSet {
                DispatchQueue.main.async {
                    self.hourWeather.reloadData()
                }
            }
        }
    
    init() {
        self.hourlyForecastData = []
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
        DispatchQueue.main.async {
            self.setupLabel()
        }
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
        view.addSubviews(connectedLabel, mainView, hourWeather, daysWeather)
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
        
        connectedLabel.textColor = .dynamicText
        connectedLabel.backgroundColor = .blue
    }
    
    private func requestUserLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    private func checkConnecting(complitionHandler: @escaping (Bool) -> Void) {
        let monitor = NWPathMonitor()
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                complitionHandler(true)
            } else {
                complitionHandler(false)
            }
        }
        
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
    private func setupLabel() {
            self.checkConnecting { isAvail in
                if isAvail {
                    print("Connected")
                } else {
                    print("Disconnected")
                }
            }
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
        hourlyForecastData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = hourWeather.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.reuseID, for: indexPath) as! CustomCollectionViewCell
        let forecast = hourlyForecastData[indexPath.item]
        cell.configure(with: forecast)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionCellSize = CGSize(width: 45, height: 100)
        return collectionCellSize
    }
    
    
}

//MARK: Table view delegate, data source methods

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weekDay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = daysWeather.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseIdentifier, for: indexPath) as! CustomTableViewCell
        cell.dayLabel.text = weekDay[indexPath.row].day
        cell.weatherImage.image = UIImage(systemName: "sun.max")
        cell.minimumTemperatureLabel.text = "Min: -10°C"
        cell.maximumTemperatureLabel.text = "Max: 0°C"
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
        let headerText = "Прогноз на 7 дней"
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
//        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension MainViewController: WeatherDelegate {
    
    func updateHourlyForecast(_ hourlyForecast: [HourlyForecast]) {
        hourlyForecastData = hourlyForecast
        DispatchQueue.main.async {
            self.hourWeather.reloadData()
            
        }
    }
    
    //MARK: Weather delegate methods
    
    func didUpdateAdvancedWeather(_ weatherManager: WeatherManager, weather: AdvancedWeatherModel, hourlyForecast: [HourlyForecast]?) {
        guard let hourlyForecastDatas = hourlyForecast else { return }
        DispatchQueue.main.async {
            self.mainView.minimumTemperatureLabel.text = "Min: \(weather.minTemp)"
            self.mainView.maximumTemperatureLabel.text = "Max: \(weather.maxTemp)"

        }
                updateHourlyForecast(hourlyForecastDatas)
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
            
            // Connected label
            connectedLabel.topAnchor.constraint(equalTo: mainView.bottomAnchor),
            connectedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            connectedLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            connectedLabel.heightAnchor.constraint(equalToConstant: Constants.thertyPoints),
            
            // Hour weather collection
            hourWeather.topAnchor.constraint(equalTo: connectedLabel.bottomAnchor),
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
