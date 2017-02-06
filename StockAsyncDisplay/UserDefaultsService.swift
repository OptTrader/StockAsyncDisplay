//
//  UserDefaultsService.swift
//  StockAsyncDisplay
//
//  Created by Chris Kong on 1/11/17.
//  Copyright © 2017 Chris Kong. All rights reserved.
//

import Foundation

class UserDefaultsService {
    
    // MARK: Methods
    
    public class func getTickers() -> [String] {
        let userDefaults = UserDefaults.standard
        var tickers: [String] {
            get {
                if let returnValue = userDefaults.object(forKey: Constants.UserDefaultsFavoriteStocks) {
                    return returnValue as! [String]
                } else {
                    return ["AAPL", "GOOG", "TSLA", "SPY", "SBUX", "MSFT", "FB", "TWTR", "YHOO", "BABA", "AMZN", "NFLX", "YELP", "EBAY"]
                }
            }
            set {
                userDefaults.set(newValue, forKey: Constants.UserDefaultsFavoriteStocks)
                userDefaults.synchronize()
            }
        }
        return tickers
    }
    
    public class func saveTickers(tickers: [String]) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(tickers, forKey: Constants.UserDefaultsFavoriteStocks)
        userDefaults.synchronize()
    }
    
    public class func deleteTicker(ticker: String) {
        var tickers: [String] = self.getTickers()
        tickers.remove(at: tickers.index(of: ticker)!)
        self.saveTickers(tickers: tickers)
    }
    
    // MARK: Constants
    
    private struct Constants {
        static let UserDefaultsFavoriteStocks = "favoriteStocks"
    }

}
