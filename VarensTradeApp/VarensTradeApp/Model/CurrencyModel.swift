//
//  CurrencyModel.swift
//  VarensTradeApp
//
//  Created by Obeisun Timothy on 07/02/2022.
//

import Foundation


struct CurrencyModel: Codable {
    var uuid = UUID()
    let logo: String
    let coin: String
    let coinColor: String
}


extension CurrencyModel: Hashable {
    static func ==(lhs: CurrencyModel, rhs: CurrencyModel) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
