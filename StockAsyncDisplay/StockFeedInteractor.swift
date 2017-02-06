//
//  StockFeedInteractor.swift
//  StockAsyncDisplay
//
//  Created by Chris Kong on 1/11/17.
//  Copyright © 2017 Chris Kong. All rights reserved.
//

import Foundation

final class StockFeedInteractor: StockFeedInteractorInput {
    var feedDataManager: FeedDataManager?
    var output: StockFeedInteractorOutput?
    
    func findStocks() {
        feedDataManager?.searchForStocks(completion: output!.foundStockItems)
    }
}
