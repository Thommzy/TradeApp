//
//  StatModel.swift
//  VarensTradeApp
//
//  Created by Obeisun Timothy on 05/02/2022.
//

import Foundation

enum Section {case first}

import Foundation
import UIKit

struct StatModel: Codable {
    var uuid = UUID()
    let icon: String
    let title: String
    let price: String
}

extension StatModel: Hashable {
    static func ==(lhs: StatModel, rhs: StatModel) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
