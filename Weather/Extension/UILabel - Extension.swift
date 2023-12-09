//
//  UILabel - Extension.swift
//  Weather
//
//  Created by Nikita on 09.12.2023.
//

import UIKit

extension UILabel {

    //MARK: - Custom initialize
    
    convenience init(text: String, font: UIFont, textColor: UIColor, textAlignment: NSTextAlignment) {
        self.init(frame: .infinite)
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
    }
}
