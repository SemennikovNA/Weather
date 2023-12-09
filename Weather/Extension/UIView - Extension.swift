//
//  UIView - Extension.swift
//  Weather
//
//  Created by Nikita on 09.12.2023.
//

import UIKit

extension UIView {
    
    //MARK: - Extension methods
    
    func addSubviews(_ view: UIView...) {
        view.forEach { views in
            views.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(views)
        }
    }
}
