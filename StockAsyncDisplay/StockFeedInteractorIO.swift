//
//  StockFeedInteractorIO.swift
//  StockAsyncDisplay
//
//  Created by Chris Kong on 1/11/17.
//  Copyright © 2017 Chris Kong. All rights reserved.
//

import Foundation

protocol StockFeedInteractorInput {
    func findStocks()
}

protocol StockFeedInteractorOutput {
    func foundStockItems(_ stocks: [Stock]?, error: Error?)
}
