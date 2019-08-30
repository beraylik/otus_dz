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
    
    // MARK: - HEX Support
    
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt32 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt32(&rgb) else { return nil }
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
            
        } else {
            return nil
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    // MARK: - Computed Properties
    
    var toHex: String? {
        return toHex()
    }
    
    // MARK: - From UIColor to String
    
    func toHex(alpha: Bool = false) -> String? {
        guard let components = cgColor.components, components.count >= 3 else {
            return nil
        }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        if alpha {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
    
}
