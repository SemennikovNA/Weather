//
//  MainViewController.swift
//  Weather
//
//  Created by Nikita on 09.12.2023.
//

import UIKit

class MainViewController: UIViewController {

    //MARK: - UI Elements
    
    private lazy var mainView = MainView()
    private lazy var hourWeather = HourlyWeatherCollection()
    private lazy var daysWeather = DaysWeatherTable()
    
    //MARK: - Properties
    let hourWeatherInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    let weekDay = [Week(day: "Sunday"),
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
        setupConstraints()
    }

    //MARK: - Private methods
    
    private func setupView() {
        // Setup view
        self.view.addSubviews(mainView, hourWeather, daysWeather)
        
        // Setup main view
        mainView.backgroundColor = .back
        
        // Days weather table
        daysWeather.showsVerticalScrollIndicator = false
        daysWeather.dataSource = self
        daysWeather.delegate = self
        
        // Hour weather collection
        hourWeather.delegate = self
        hourWeather.dataSource = self
        hourWeather.showsHorizontalScrollIndicator = false
        hourWeather.backgroundColor = .back
        hourWeather.contentInset = UIEdgeInsets(top: hourWeatherInsets.top, left: hourWeatherInsets.left, bottom: hourWeatherInsets.bottom, right: hourWeatherInsets.right)
        
    }
}

//MARK: - Extension

extension MainViewController {
    
    /// Value for constants
    private enum Constants {
        static let tenPoints: CGFloat = 10
        static let twentyPoints: CGFloat = 20
        static let hourWeatherHeight: CGFloat = 100
        static let hourWeatherTopIdent: CGFloat = 300
    }
    
    /// Setup constraints for user elements
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            // Main view
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Hour weather collection
            hourWeather.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.hourWeatherTopIdent),
            hourWeather.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: Constants.twentyPoints),
            hourWeather.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -Constants.twentyPoints),
            hourWeather.heightAnchor.constraint(equalToConstant: Constants.hourWeatherHeight),
            
            // Days table
            daysWeather.topAnchor.constraint(equalTo: hourWeather.bottomAnchor, constant: Constants.tenPoints),
            daysWeather.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: Constants.twentyPoints),
            daysWeather.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -Constants.twentyPoints),
            daysWeather.bottomAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.twentyPoints),
        ])
    }
}

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
        return CGSize(width: 45, height: 100)
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
        60
    }
}
