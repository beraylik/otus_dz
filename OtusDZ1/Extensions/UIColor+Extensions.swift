//
//  UIColor+Extensions.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 13/06/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import UIKit

// MARK: - Custom colors
extension UIColor {
    
    // Random color
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1
        )
    }
    
    // Custom Colors
    static let niceRed = UIColor(red: 255/255, green: 68/255, blue: 68/255, alpha: 1)
    static let niceGreen = UIColor(red: 128/255, green: 192/255, blue: 128/255, alpha: 1)
    
}

// MARK: - UIColor extensions

extension UIColor {
    
    var preffersDarkContent: Bool {
        let contrast = self.contrastWith(UIColor.init(red: 1, green: 1, blue: 1, alpha: 1))
        return contrast < 3.5
    }
    
    private func contrastWith(_ color: UIColor) -> CGFloat {
        let selfLuminance = UIColor.luminanceFor(self)
        let otherLuminance = UIColor.luminanceFor(color)
        return max(selfLuminance, otherLuminance) / min(selfLuminance, otherLuminance)
    }
    
    static private func luminanceFor(_ color: UIColor) -> CGFloat {
        let componets = color.cgColor.components ?? []
        
        var a: [CGFloat] = componets.map({
            let devided = $0 / 255
            if devided <= 0.03928 {
                return devided / 12.92
            } else {
                return pow((devided + 0.055) / 1.055, 2.4)
            }
        })
        return a[0] * 0.2126 + a[1] * 0.7152 + a[2] * 0.0722
    }
    
}
