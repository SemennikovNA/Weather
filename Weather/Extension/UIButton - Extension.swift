//
//  UIButton - Extension.swift
//  Weather
//
//  Created by Nikita on 09.12.2023.
//

import UIKit

extension UIButton {
    
    convenience init(image: String?, tintColor: UIColor) {
        self.init(frame: .infinite)
        self.tintColor = tintColor
        if let image = image {
            self.setImage(UIImage(systemName: image), for: .normal)
        }
    }
}
