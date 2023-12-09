//
//  MainView.swift
//  Weather
//
//  Created by Nikita on 09.12.2023.
//

import UIKit

class MainView: UIView {
    
    //MARK: - UI Elements
    
    let cityLabel = UILabel(text: "Miami", font: .boldSystemFont(ofSize: 25), textColor: .dynamicText, textAlignment: .center)
    let temperatureLabel = UILabel(text: "-10°C", font: .systemFont(ofSize: 54), textColor: .dynamicText, textAlignment: .center)
    let descriptionWeatherLabel = UILabel(text: "Солнечно", font: .systemFont(ofSize: 25), textColor: .dynamicText, textAlignment: .center)
    let minimumTemperatureLabel = UILabel(text: "Min: -20°C", font: .systemFont(ofSize: 10), textColor: .dynamicText, textAlignment: .right)
    let maximumTemperatureLabel = UILabel(text: "Max: 0°C", font: .systemFont(ofSize: 10), textColor: .dynamicText, textAlignment: .left)
    let verticalStack = UIStackView(axis: .vertical)
    let horizontalStack = UIStackView(axis: .horizontal)
    
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
    
    //MARK: - Private methods
    /// Setup main view user elements
    private func setupView() {
        self.backgroundColor = .white
        self.addSubviews(cityLabel, temperatureLabel, descriptionWeatherLabel, minimumTemperatureLabel, maximumTemperatureLabel, verticalStack, horizontalStack)
        verticalStack.addArrangedSubviews(cityLabel, temperatureLabel, descriptionWeatherLabel)
        verticalStack.distribution = .fillEqually
        horizontalStack.spacing = 10
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
        static let verticalStackWidth: CGFloat = 200
        static let horizontalStackWidth: CGFloat = 110
    }
    
    /// Constraints for main view
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            // Vertical stack
            verticalStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constants.fiftyPoint),
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
