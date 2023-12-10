//
//  UILabel - Extension.swift
//  Weather
//
//  Created by Nikita on 09.12.2023.
//

import UIKit

extension UILabel {

    //MARK: - Custom initialize
    
    convenience init(text: String? = nil, font: UIFont? = .systemFont(ofSize: 15), textColor: UIColor? = .dynamicText, textAlignment: NSTextAlignment? = .center) {
        self.init(frame: .infinite)
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment!
    }
}
