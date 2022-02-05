//
//  VarensView.swift
//  VarensTradeApp
//
//  Created by Obeisun Timothy on 05/02/2022.
//

import Foundation
import UIKit

@IBDesignable
class VarensView: UIView {
    @IBInspectable
    public var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            
        }
    }
    
    @IBInspectable
    public var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    public var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.borderColor!.cgColor)
        }
        
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
}
