//
//  UITextField - Extension.swift
//  Weather
//
//  Created by Nikita on 09.12.2023.
//

import UIKit

extension UITextField {
    
    convenience init(placeholder: String, returnKey: UIReturnKeyType, textColor: UIColor, tintColor: UIColor) {
        self.init(frame: .infinite)
        self.placeholder = placeholder
        self.returnKeyType = returnKey
        self.textColor = textColor
        self.tintColor = tintColor
    }
}
