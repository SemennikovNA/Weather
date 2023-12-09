//
//  DaysWeatherTable.swift
//  Weather
//
//  Created by Nikita on 09.12.2023.
//

import UIKit

class DaysWeatherTable: UITableView {

    //MARK: - Inititalize

    
    override init(frame: CGRect, style: UITableView.Style) {
         super.init(frame: frame, style: style)
        
        // Call function's
        setupTable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    
    private func setupTable() {
        register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.reuseIdentifier)
    }
}
