//
//  ExchangeTableViewCell.swift
//  VarensTradeApp
//
//  Created by Obeisun Timothy on 07/02/2022.
//

import UIKit

class ExchangeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellCurrencyView: CurrencyView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.cellCurrencyView.changeBtnView.isHidden = true
    }
    
    var currency: CurrencyModel? {
        didSet {
            let image = UIImage(named: currency!.logo)
            cellCurrencyView.currencyImageView.image = image
            cellCurrencyView.coinLbl.textColor = UIColor(named: currency!.coinColor)
            cellCurrencyView.coinLbl.text = currency?.coin
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
