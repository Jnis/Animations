//
//  UIColor+HEX.swift
//  Animations
//
//  Created by Yanis Plumit on 14/07/2019.
//  Copyright © 2019 Yanis Plumit. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt32 = 0
        _ = Scanner(string: hexSanitized).scanHexInt32(&rgb)
        self.init(long: rgb, alpha: hexSanitized.count == 8)
    }
    
    convenience init(long: UInt32, alpha: Bool = false) {
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        if alpha {
            r = CGFloat((long & 0xFF000000) >> 24) / 255.0
            g = CGFloat((long & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((long & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(long & 0x000000FF) / 255.0
        } else {
            r = CGFloat((long & 0xFF0000) >> 16) / 255.0
            g = CGFloat((long & 0x00FF00) >> 8) / 255.0
            b = CGFloat(long & 0x0000FF) / 255.0
        }
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    var toHexString: String {
        return toHexString()
    }
    
    var toLong: UInt32 {
        return toLong()
    }
    
    func toHexString(alpha: Bool = false) -> String {
        if alpha {
            return String(format:"#%08x", toLong(alpha: alpha))
        } else {
            return String(format:"#%06x", toLong(alpha: alpha))
        }
    }
    
    func toLong(alpha: Bool = false) -> UInt32 {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        if alpha {
            let rgba: UInt32 = (UInt32)(r * 255) << 24 | (UInt32)(g * 255) << 16 | (UInt32)(b * 255 ) << 8 | (UInt32)(a * 255 ) << 0
            return rgba
        } else {
            let rgb: UInt32 = (UInt32)(r * 255) << 16 | (UInt32)(g * 255) << 8 | (UInt32)(b * 255 ) << 0
            return rgb
        }
    }
    
}
