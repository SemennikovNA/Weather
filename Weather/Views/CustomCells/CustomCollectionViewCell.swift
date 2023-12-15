//
//  CustomCollectionViewCell.swift
//  Weather
//
//  Created by Nikita on 09.12.2023.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let reuseID = "CollectionCell"
    
    //MARK: - UI elements
    let cellView = UIView()
    let hourLabel = UILabel(font: .systemFont(ofSize: 12), textColor: .dynamicText, textAlignment: .center)
    let weathedImage = UIImageView()
    let temperatureLabel = UILabel(font: .systemFont(ofSize: 12), textColor: .dynamicText, textAlignment: .center)
    
    //MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Call function's
        setupCell()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public methods
    
    func configure(with forecast: HourlyForecast) {
        let date = Date(timeIntervalSince1970: TimeInterval(forecast.time))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let formattedTime = dateFormatter.string(from: date)
        hourLabel.text = formattedTime
        let tempFormat = forecast.temperature
        temperatureLabel.text = String(format: "%.0f", tempFormat)
        let weatImg = forecast.icon
        weathedImage.image = UIImage(systemName: weatImg)
    }
    
    //MARK: - Private methods
    
    private func setupCell() {
        contentView.addSubviews(cellView)
        cellView.addSubviews(hourLabel, weathedImage, temperatureLabel)
        weathedImage.tintColor = .dynamicText
    }
}

//MARK: - Extension

extension CustomCollectionViewCell {
    
    /// Value for constraints collection cell
    private enum Constants {
        static let tenPoints: CGFloat = 10
        static let labelHeight: CGFloat = 50
        static let labelWidth: CGFloat = 70
        static let weatherImageWidthAndHeight: CGFloat = 40
    }
    
    /// Constraints for collection cell
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            // Cell view
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // Hour label
            hourLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: -Constants.tenPoints),
            hourLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            hourLabel.widthAnchor.constraint(equalToConstant: Constants.labelWidth),
            hourLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight),
            
            // Weather image
            weathedImage.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            weathedImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            weathedImage.widthAnchor.constraint(equalToConstant: Constants.weatherImageWidthAndHeight),
            weathedImage.heightAnchor.constraint(equalToConstant: Constants.weatherImageWidthAndHeight),
            
            // Temperature label
            temperatureLabel.topAnchor.constraint(equalTo: weathedImage.bottomAnchor, constant: -Constants.tenPoints),
            temperatureLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            temperatureLabel.widthAnchor.constraint(equalToConstant: Constants.labelWidth),
            temperatureLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight),
        ])
    }
}
