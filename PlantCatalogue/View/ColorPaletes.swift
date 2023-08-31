//
//  ColorPaletes.swift
//  PlantCatalogue
//
//  Created by Laureano Velasco on 18/08/2023.
//

import UIKit

extension UIColor {
    
    static let darkGreen = UIColor(hex: 0x028174)
    static let midGreen = UIColor(hex: 0x0AB68B)
    static let lightGreen = UIColor(hex: 0x92DE8B)
    static let sweetBrown = UIColor(hex: 0xFFE3B3)
    
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255,
            green: CGFloat(green) / 255,
            blue: CGFloat(blue) / 255,
            alpha: a
        )
    }
    
    convenience init(hex: Int, a:CGFloat = 1.0) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF
        )
    }
}
