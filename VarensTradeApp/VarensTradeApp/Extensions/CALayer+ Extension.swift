//
//  CALayer+ Extension.swift
//  VarensTradeApp
//
//  Created by Obeisun Timothy on 05/02/2022.
//

import Foundation
import QuartzCore
import UIKit

extension CALayer {
    @IBInspectable var borderUIColor: UIColor? {
        get {
            guard let borderColor = borderColor else { return nil }
            return UIColor(cgColor: borderColor)
            
        }
        set {
            borderColor = newValue?.cgColor
        }
    }
}
