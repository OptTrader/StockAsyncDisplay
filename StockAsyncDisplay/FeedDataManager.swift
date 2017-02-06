//
//  FeedDataManager.swift
//  StockAsyncDisplay
//
//  Created by Chris Kong on 1/1/17.
//  Copyright © 2017 Chris Kong. All rights reserved.
//

import Foundation
import SwiftyJSON

final class FeedDataManager {
    
    fileprivate var _networkService: NetworkService?
    
    init(networkService: NetworkService) {
        _networkService = networkService
    }
    
    func searchForStocks(completion: @escaping ( _ stocks: [Stock]?, _ error: Error?) -> ()) {
        var equityTickers: Array<String> = []
        let symbols = UserDefaultsService.getTickers()
        for symbol in symbols {
            equityTickers.append(symbol)
        }
        
        _networkService?.requestEquityData(symbols: equityTickers, onSuccess: { results in
            completion(results, nil)
            
        }, onError: { error in
            print(error.localizedDescription)
            completion(nil, error)
        })
        
//        _networkService?.fetchQuotesFromSymbols(symbols: equityTickers, completion: { (results, error) in
//            guard error == nil else {
//                completion(nil, error)
//                return
//            }
//            print(results)
//            let stocks = results?.flatMap(self.stockItemFromJSONDictionary)
//            print(stocks)
//            completion(stocks, nil)
//        })
    }
    

    
//    func stockItemFromJSONDictionary(_ entry: JSONDictionary) -> Stock? {
//        guard let symbol = entry["Symbol"] as? String,
//            let companyName = entry["Name"] as? String,
//            let lastTradePrice = entry["LastTradePriceOnly"] as? Double,
//            let previousClosePrice = entry["PreviousClose"] as? Double,
//            let changeInPrice = entry["Change"] as? Double
//            else {
//                return nil
//        }
//        
//        return Stock(symbol: symbol,
//                     companyName: companyName,
//                     lastTradePrice: lastTradePrice,
//                     previousClosePrice: previousClosePrice,
//                     changeInPrice: changeInPrice
//        )
//    }

}
