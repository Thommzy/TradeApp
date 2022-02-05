//
//  VarensImageView.swift
//  VarensTradeApp
//
//  Created by Obeisun Timothy on 05/02/2022.
//

import Foundation
import UIKit

@IBDesignable
class VarensImageView: UIImageView {
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            
        }
    }
}
