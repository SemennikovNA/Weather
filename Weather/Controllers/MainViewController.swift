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
    let hourWeatherInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    let weekDay = [
        Week(day: "Sunday"),
        Week(day: "Monday"),
        Week(day: "Tuesday"),
        Week(day: "Wednesday"),
        Week(day: "Thursday"),
        Week(day: "Friday")
    ]
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call fucntion's
        setupView()
        signatureDelegate()
        requestUserLocation()
        setupConstraints()
        
        checkConnecting { isConnected in
            if isConnected {
                print("Есть подключение")
            } else {
                print("Нет подключения")
            }
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
    
   private func checkConnecting(completionHandler: @escaping (Bool) -> Void) {
        let monitor = NWPathMonitor()

        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        }

        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
    //MARK: - Objectiv-C methods
    
    @objc func locationButtonTapped() {
        locationManager.requestLocation()
    }
    
    @objc func searchButtonTapped() {
        mainView.searchTextField.endEditing(true)
        print("city")
    }
    
}

//MARK: - Extension

//MARK: Collection view delegate, data source and flow layout methods

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        weekDay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = hourWeather.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.reuseID, for: indexPath) as! CustomCollectionViewCell
        cell.hourLabel.text = "12:00"
        cell.weathedImage.image = UIImage(systemName: "sun.max")
        cell.temperatureLabel.text = "-10°C"
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
}

//MARK: Text field delegate

extension MainViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = mainView.searchTextField.text else { return }
        print(text)
        mainView.searchTextField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mainView.searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if mainView.searchTextField.text != "" {
            return true
        } else {
            mainView.searchTextField.placeholder = "Нужно ввести город"
            return false
        }
    }
}

//MARK: Core location delegate

extension MainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        print(latitude, longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

//MARK: Constraints for view

extension MainViewController {
    
    /// Value for constants
    private enum Constants {
        static let tenPoints: CGFloat = 10
        static let twentyPoints: CGFloat = 20
        static let hourWeatherHeight: CGFloat = 100
        static let mainViewHeight: CGFloat = 270
        static let hourWeatherTopIdent: CGFloat = 280
    }
    
    /// Setup constraints for user elements
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            // Main view
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.heightAnchor.constraint(equalToConstant: Constants.mainViewHeight),
            
            // Hour weather collection
            hourWeather.topAnchor.constraint(equalTo: mainView.bottomAnchor),
            hourWeather.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.twentyPoints),
            hourWeather.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.twentyPoints),
            hourWeather.heightAnchor.constraint(equalToConstant: Constants.hourWeatherHeight),
            
            // Days table
            daysWeather.topAnchor.constraint(equalTo: hourWeather.bottomAnchor, constant: Constants.tenPoints),
            daysWeather.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.twentyPoints),
            daysWeather.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.twentyPoints),
            daysWeather.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
