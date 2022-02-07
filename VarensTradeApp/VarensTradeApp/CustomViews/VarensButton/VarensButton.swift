//
//  VarensButton.swift
//  VarensTradeApp
//
//  Created by Obeisun Timothy on 05/02/2022.
//

import UIKit

@IBDesignable class VarensButton: UIView {
    
    @IBOutlet weak var varensButton: UIButton!
    @IBOutlet var rootView: UIView!
    
    var onClick:((_ stButton:String)->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        rootView = loadViewFromNib(nibName: "VarensButton")
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
    
    @IBAction func TimButtonAction(_ sender: UIButton) {
        guard let onClick = onClick else {
            return
        }
        onClick(varensButton.titleLabel?.text ?? String())
    }
}


extension VarensButton {
    func setupCustomStyle(backgroundColor: UIColor, title: String, titleColor: UIColor, fontSize: CGFloat) {
        self.varensButton.backgroundColor = backgroundColor
        self.varensButton.setTitle(title, for: .normal)
        self.varensButton.setTitleColor(titleColor, for: .normal)
        self.varensButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
    }
}
