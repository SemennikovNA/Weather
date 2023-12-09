//
//  MainViewController.swift
//  Weather
//
//  Created by Nikita on 09.12.2023.
//

import UIKit

class MainViewController: UIViewController {

    //MARK: - User Elements
    
    private lazy var mainView = MainView()
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call fucntion's
        setupView()
        setupConstraints()
    }

    //MARK: - Private methods
    
    private func setupView() {
        self.view.addSubviews(mainView)
    }
}

//MARK: - Extension

private extension MainViewController {
    
    /// Value for constants
    private enum Constants {
        
    }
    
    /// Setup constraints for user elements
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            // Main view
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
