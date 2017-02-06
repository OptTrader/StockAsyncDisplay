//
//  Stock.swift
//  StockAsyncDisplay
//
//  Created by Chris Kong on 1/1/17.
//  Copyright © 2017 Chris Kong. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Stock {
    let symbol: String!
    let companyName: String!
    let lastTradePrice: Double!
    let previousClosePrice: Double!
    let changeInPrice: Double!
    
    var changeInPercent: Double {
        return changeInPrice / previousClosePrice
    }
    
}

extension Stock {
    init(json: JSON) {
        self.symbol = json["Symbol"].stringValue
        self.companyName = json["Name"].stringValue
        self.lastTradePrice = json["LastTradePriceOnly"].doubleValue
        self.previousClosePrice = json["PreviousClose"].doubleValue
        self.changeInPrice = json["Change"].doubleValue
    }
}
