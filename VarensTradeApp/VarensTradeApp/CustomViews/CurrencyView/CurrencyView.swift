//
//  CurrencyView.swift
//  VarensTradeApp
//
//  Created by Obeisun Timothy on 07/02/2022.
//

import UIKit
import SwiftCharts

protocol ChangeBtnDelegate: AnyObject {
    func changeBtnTapped()
    
}

@IBDesignable class CurrencyView: UIView {
    
    @IBOutlet weak var chartyView: UIView!
    @IBOutlet weak var mainBackground: UIView!
    @IBOutlet var rootView: UIView!
    @IBOutlet weak var changeBtn: VarensButton!
    @IBOutlet weak var currencyImageView: UIImageView!
    @IBOutlet weak var currAmountLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var changeBtnView: UIView!
    @IBOutlet weak var amountsView: UIView!
    @IBOutlet weak var coinLbl: UILabel!
    
    var chart: Chart!
    
    weak var delegate: ChangeBtnDelegate?
    var isViews: Bool = false
    var onClick:((_ stButton:String)->Void)?
    
    var isView:((_ main:Bool)->Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setupChangeBtn()
        
        btnAction()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        setupChangeBtn()
        btnAction()
    }
    
    func btnAction() {
        changeBtn.onClick = { btnTitle in
            if btnTitle == "Change" {
                self.delegate?.changeBtnTapped()
            }
        }
    }
    
    func setupChangeBtn() {
        let color: UIColor = #colorLiteral(red: 0.3937771916, green: 0.4002127349, blue: 0.9762862325, alpha: 1)
        changeBtn.setupCustomStyle(backgroundColor: UIColor.clear, title: "Change", titleColor: color, fontSize: 12.0)
        changeBtn.layer.borderWidth = 1
        changeBtn.layer.borderColor = #colorLiteral(red: 0.7215686275, green: 0.7215686275, blue: 0.7215686275, alpha: 1)
        changeBtn.layer.cornerRadius = 7
        changeBtn.layer.masksToBounds = true
    }
    
    private func commonInit() {
        rootView = loadViewFromNib(nibName: "CurrencyView")
        rootView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        rootView.frame = self.bounds
        addSubview(rootView)
    }
    
    func loadViewFromNib(nibName: String) -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
}
