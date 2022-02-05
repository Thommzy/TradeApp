//
//  StatTableViewCell.swift
//  VarensTradeApp
//
//  Created by Obeisun Timothy on 05/02/2022.
//

import UIKit

class StatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var marketDescriptionLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var stat: StatModel? {
        didSet {
            marketDescriptionLbl.text = stat?.title
            priceLbl.text = stat?.price
            let image = UIImage(named: stat!.icon)
            iconImageView.image = image
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
