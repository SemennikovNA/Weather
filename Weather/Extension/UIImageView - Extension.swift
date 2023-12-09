//
//  UIImageView - Extension.swift
//  Weather
//
//  Created by Nikita on 09.12.2023.
//

import UIKit

extension UIImageView {
    
    convenience init(tintColor: UIColor) {
        self.init(frame: .infinite)
        self.tintColor = tintColor
    }
}
