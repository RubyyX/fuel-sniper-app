//
//  SitePrice.swift
//  Fuel Sniper
//
//  Created by Ethan Colgan on 3/12/21.
//

import Foundation

struct SitePrice: Codable {
    var SiteId: Int
    var FuelId: Int
    var CollectionMethod: String
    var TransactionDateUtc: String
    var Price: Float
}
