//
//  HourlyWeatherCollection.swift
//  Weather
//
//  Created by Nikita on 09.12.2023.
//

import UIKit

class HourlyWeatherCollection: UICollectionView {

    //MARK: - Initialize
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        setupCollection()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    
    private func setupCollection() {
        register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.reuseID)
    }
}
