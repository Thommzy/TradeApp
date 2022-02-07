//
//  ExChangeBottomViewController.swift
//  VarensTradeApp
//
//  Created by Obeisun Timothy on 07/02/2022.
//

import UIKit

class ExChangeBottomViewController: BottomPopupViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func cancelBtnAction(_ sender: UIButton) {
        print("Cancel")
        self.dismiss(animated: true, completion: nil)
    }
    
    override var popupHeight: CGFloat { return  view.frame.size.height - 70 }
    
    override var popupTopCornerRadius: CGFloat { return CGFloat(25) }
    
    override var popupPresentDuration: Double { return 0.30 }
    
    override var popupDismissDuration: Double { return 0.30 }
    
    override var popupShouldDismissInteractivelty: Bool { return true }
    
    override var popupDimmingViewAlpha: CGFloat { return 0.5 }
}
