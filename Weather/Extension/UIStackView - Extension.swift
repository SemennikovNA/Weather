//
//  UIStackView - Extension.swift
//  Weather
//
//  Created by Nikita on 09.12.2023.
//

import UIKit

extension UIStackView {
    
    //MARK: - Custom initialize
    
    convenience init(axis: NSLayoutConstraint.Axis) {
        self.init(frame: .infinite)
        self.axis = axis
    }
    
    //MARK: - Extension methods
    
    func addArrangedSubviews(_ view: UIView...) {
        view.forEach { views in
            views.translatesAutoresizingMaskIntoConstraints = false
            self.addArrangedSubview(views)
        }
    }
}
