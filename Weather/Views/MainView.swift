//
//  MainView.swift
//  Weather
//
//  Created by Nikita on 09.12.2023.
//

import UIKit

class MainView: UIView {
    
    //MARK: - Properties

    let stackSpacingValue: CGFloat = 10
    
    //MARK: - UI Elements
    
    let searchView = UIView()
    let locationButton = UIButton(image: "location.fill", tintColor: .dynamicText)
    let searchButton = UIButton(image: "magnifyingglass", tintColor: .dynamicText)
    let searchTextField = UITextField(placeholder: "Введите город...", returnKey: .search, textColor: .dynamicText, tintColor: .dynamicText)
    let cityLabel = UILabel(text: "Miami", font: .boldSystemFont(ofSize: 25), textColor: .dynamicText, textAlignment: .center)
    let temperatureLabel = UILabel(text: "-10°C", font: .systemFont(ofSize: 54), textColor: .dynamicText, textAlignment: .center)
    let descriptionWeatherLabel = UILabel(text: "Солнечно", font: .systemFont(ofSize: 25), textColor: .dynamicText, textAlignment: .center)
    let minimumTemperatureLabel = UILabel(text: "Min: -20°C", font: .systemFont(ofSize: 15), textColor: .dynamicText, textAlignment: .right)
    let maximumTemperatureLabel = UILabel(text: "Max: 0°C", font: .systemFont(ofSize: 15), textColor: .dynamicText, textAlignment: .left)
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
    
    func locationButtonAddTarget(target: Any, selector: Selector) {
        locationButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
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
        horizontalStack.spacing = stackSpacingValue
        horizontalStack.addArrangedSubviews(minimumTemperatureLabel, maximumTemperatureLabel)
    }
}

//MARK: - Private extension

private extension MainView {
    
    /// Value for constraints main view
    private enum Constants {
        
        static let tenPoints: CGFloat = 10
        static let twentyPoints: CGFloat = 20
        static let fiftyPoint: CGFloat = 50
        static let verticalStackHeight: CGFloat = 130
        static let horizontalStackWidth: CGFloat = 160
        static let verticalStackWidth: CGFloat = 200
        static let searchViewWidth: CGFloat = 350
        
    }
    
    /// Constraints for main view
    private func setupConstraints() {
        
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
            searchTextField.leadingAnchor.constraint(equalTo: locationButton.trailingAnchor, constant: Constants.tenPoints),
            searchTextField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: Constants.tenPoints),
            searchTextField.heightAnchor.constraint(equalToConstant: Constants.fiftyPoint),
            
            
            // Vertical stack
            verticalStack.topAnchor.constraint(equalTo: searchView.bottomAnchor),
            verticalStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            verticalStack.heightAnchor.constraint(equalToConstant: Constants.verticalStackHeight),
            verticalStack.widthAnchor.constraint(equalToConstant: Constants.verticalStackWidth),
            
            // Horizontal stack
            horizontalStack.topAnchor.constraint(equalTo: verticalStack.bottomAnchor, constant: Constants.tenPoints),
            horizontalStack.heightAnchor.constraint(equalToConstant: Constants.twentyPoints),
            horizontalStack.widthAnchor.constraint(equalToConstant: Constants.horizontalStackWidth),
            horizontalStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}
