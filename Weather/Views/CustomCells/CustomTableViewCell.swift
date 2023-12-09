//
//  CustomTableViewCell.swift
//  Weather
//
//  Created by Nikita on 09.12.2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    //MARK: - Properties
    
    static let reuseIdentifier = "TableCell"
    
    //MARK: - UI Elemetns
    
    let cellView = UIView()
    let dayLabel = UILabel(font: .boldSystemFont(ofSize: 20), textColor: .black, textAlignment: .left)
    let weatherImage = UIImageView()
    let minimumTemperatureLabel = UILabel(font: .systemFont(ofSize: 14), textColor: .dynamicText, textAlignment: .center)
    let maximumTemperatureLabel = UILabel(font: .systemFont(ofSize: 14), textColor: .dynamicText, textAlignment: .center)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        // Call function's
        setupCell()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    
    private func setupCell() {
        contentView.addSubviews(cellView)
        cellView.addSubviews(dayLabel, weatherImage, minimumTemperatureLabel, maximumTemperatureLabel)
        weatherImage.tintColor = .black
    }
}

extension CustomTableViewCell {
    
    /// Value for constants
    private enum Constants {
        static let fivePoints: CGFloat = 5
        static let tenPoints: CGFloat = 10
        static let twentyPoints: CGFloat = 20
        static let thirtyFivePoints: CGFloat = 35
        static let dayLabelHeight: CGFloat = 30
        static let temperatureLabelWidth: CGFloat = 80
        static let dayLabelWidth: CGFloat = 110
    }
    
    /// Setup constraints for user elements in table cell
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            // Cell view
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // Day label
            dayLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            dayLabel.heightAnchor.constraint(equalToConstant: Constants.dayLabelHeight),
            dayLabel.widthAnchor.constraint(equalToConstant: Constants.dayLabelWidth),
            
            // Weather image
            weatherImage.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            weatherImage.leadingAnchor.constraint(equalTo: dayLabel.trailingAnchor, constant: Constants.tenPoints),
            weatherImage.heightAnchor.constraint(equalToConstant: Constants.thirtyFivePoints),
            weatherImage.widthAnchor.constraint(equalToConstant: Constants.thirtyFivePoints),
            
            // Minimum temperature label
            minimumTemperatureLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            minimumTemperatureLabel.leadingAnchor.constraint(equalTo: weatherImage.trailingAnchor, constant: Constants.twentyPoints),
            minimumTemperatureLabel.heightAnchor.constraint(equalToConstant: Constants.thirtyFivePoints),
            minimumTemperatureLabel.widthAnchor.constraint(equalToConstant: Constants.temperatureLabelWidth),
            
            // Maximum temperature label
            maximumTemperatureLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            maximumTemperatureLabel.leadingAnchor.constraint(equalTo: minimumTemperatureLabel.trailingAnchor, constant: Constants.fivePoints),
            maximumTemperatureLabel.heightAnchor.constraint(equalToConstant: Constants.thirtyFivePoints),
            maximumTemperatureLabel.widthAnchor.constraint(equalToConstant: Constants.temperatureLabelWidth),
        ])
    }
}

#Preview {
    MainViewController()
}
