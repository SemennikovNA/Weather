//
//  CustomTableViewCell.swift
//  Weather
//
//  Created by Nikita on 09.12.2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    //MARK: - Properties
    
    static let reuseID = "TabelCell"
    
    //MARK: - UI Elemetns
    
    let cellView = UIView()
    let dayLabel = UILabel(font: .boldSystemFont(ofSize: 12), textColor: .dynamicText, textAlignment: .left)
    let weatherImage = UIImageView()
    let minimumTemperatureLabel = UILabel(font: .systemFont(ofSize: 14), textColor: .dynamicText, textAlignment: .center)
    let maximumTemperatureLabel = UILabel(font: .systemFont(ofSize: 14), textColor: .dynamicText, textAlignment: .center)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Call fucntion's
        setupCell()
        setupConstraints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //MARK: - Private methods
    
    private func setupCell() {
        contentView.addSubviews(cellView)
        cellView.addSubviews(dayLabel, weatherImage, minimumTemperatureLabel, maximumTemperatureLabel)
    }
}

extension CustomTableViewCell {
    
    /// Value for constants
    private enum Constants {
        static let fivePoints: CGFloat = 5
        
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
            dayLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: Constants.fivePoints),
            
            // Weather image
            weatherImage.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            weatherImage.leadingAnchor.constraint(equalTo: dayLabel.trailingAnchor, constant: Constants.fivePoints),
            
            // Minimum temperature label
            minimumTemperatureLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            minimumTemperatureLabel.leadingAnchor.constraint(equalTo: weatherImage.trailingAnchor, constant: Constants.fivePoints),
            
            // Maximum temperature label
            maximumTemperatureLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            maximumTemperatureLabel.leadingAnchor.constraint(equalTo: minimumTemperatureLabel.trailingAnchor, constant: Constants.fivePoints)
        ])
    }
}
