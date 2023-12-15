//
//  MainView.swift
//  Weather
//
//  Created by Nikita on 09.12.2023.
//

import UIKit

class MainView: UIView {
    
    //MARK: - UI Elements
    
    let searchView = UIView()
    let locationButton = UIButton(image: "location.fill", tintColor: .dynamicText)
    let searchButton = UIButton(image: "magnifyingglass", tintColor: .dynamicText)
    let searchTextField = UITextField(placeholder: "Введите город...", returnKey: .search, textColor: .dynamicText, tintColor: .dynamicText)
    let cityLabel = UILabel(font: .boldSystemFont(ofSize: 25), textColor: .dynamicText, textAlignment: .center)
    let temperatureLabel = UILabel(font: .systemFont(ofSize: 54), textColor: .dynamicText, textAlignment: .center)
    let descriptionWeatherLabel = UILabel(font: .systemFont(ofSize: 25), textColor: .dynamicText, textAlignment: .center)
    let minimumTemperatureLabel = UILabel(font: .systemFont(ofSize: 15), textColor: .dynamicText, textAlignment: .left)
    let maximumTemperatureLabel = UILabel(font: .systemFont(ofSize: 15), textColor: .dynamicText, textAlignment: .right)
    private lazy var verticalStack = UIStackView(axis: .vertical)
    private lazy var horizontalStack = UIStackView(axis: .horizontal)
     
    //MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Call function's
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    /// Add target for location button
    func locationButtonAddTarget(target: Any, selector: Selector) {
        locationButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    /// Add target for search button
    func searchButtonAddTarget(target: Any, selector: Selector) {
        searchButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    //MARK: - Private methods
    
    /// Setup main view user elements
    private func setupView() {
        // Setup view
        self.backgroundColor = .white
        self.addSubviews(searchView, verticalStack, horizontalStack)
        searchView.addSubviews(locationButton, searchTextField, searchButton)
        
        // Setup vertical stack
        verticalStack.addArrangedSubviews(cityLabel, temperatureLabel, descriptionWeatherLabel)
        verticalStack.distribution = .fillEqually
        
        // Setup horizontal stack
        horizontalStack.addArrangedSubviews(minimumTemperatureLabel, maximumTemperatureLabel)
    }
}

//MARK: - Private extension

extension MainView {
    
    /// Value for constraints main view
    private enum Constants {
        
        static let tenPoints: CGFloat = 10
        static let twentyPoints: CGFloat = 20
        static let fiftyPoint: CGFloat = 50
        static let verticalStackHeight: CGFloat = 150
        static let horizontalStackWidth: CGFloat = 200
        static let verticalStackWidth: CGFloat = 180
        static let searchViewWidth: CGFloat = 350
        
    }
    
    /// Constraints for main view
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            // Search view
            searchView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.twentyPoints),
            searchView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.twentyPoints),
            searchView.heightAnchor.constraint(equalToConstant: Constants.fiftyPoint),
            
            // Location button in search view
            locationButton.centerYAnchor.constraint(equalTo: searchView.centerYAnchor),
            locationButton.leadingAnchor.constraint(equalTo: searchView.leadingAnchor),
            locationButton.heightAnchor.constraint(equalToConstant: Constants.fiftyPoint),
            locationButton.widthAnchor.constraint(equalToConstant: Constants.fiftyPoint),
            
            // Search button in search view
            searchButton.centerYAnchor.constraint(equalTo: searchView.centerYAnchor),
            searchButton.trailingAnchor.constraint(equalTo: searchView.trailingAnchor),
            searchButton.heightAnchor.constraint(equalToConstant: Constants.fiftyPoint),
            searchButton.widthAnchor.constraint(equalToConstant: Constants.fiftyPoint),
            
            // Search text field in search view
            searchTextField.centerYAnchor.constraint(equalTo: searchView.centerYAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: locationButton.trailingAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor),
            searchTextField.heightAnchor.constraint(equalToConstant: Constants.fiftyPoint),
            
            
            // Vertical stack
            verticalStack.topAnchor.constraint(equalTo: searchView.bottomAnchor),
            verticalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            verticalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            verticalStack.heightAnchor.constraint(equalToConstant: Constants.verticalStackHeight),
            
            // Horizontal stack
            horizontalStack.topAnchor.constraint(equalTo: verticalStack.bottomAnchor, constant: Constants.tenPoints),
            horizontalStack.heightAnchor.constraint(equalToConstant: Constants.twentyPoints),
            horizontalStack.widthAnchor.constraint(equalToConstant: Constants.horizontalStackWidth),
            horizontalStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}
