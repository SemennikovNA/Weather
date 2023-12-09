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
    
    //MARK: - Properties
    let hourWeatherInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    
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
        self.view.addSubviews(mainView, hourWeather)
        
        // Setup main view
        mainView.backgroundColor = .back
        
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
            hourWeather.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.twentyPoints),
            hourWeather.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.twentyPoints),
            hourWeather.heightAnchor.constraint(equalToConstant: Constants.hourWeatherHeight),
        ])
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
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

#Preview {
    MainViewController()
}
