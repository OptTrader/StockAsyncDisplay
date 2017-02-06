//
//  Formatters.swift
//  StockAsyncDisplay
//
//  Created by Chris Kong on 1/12/17.
//  Copyright © 2017 Chris Kong. All rights reserved.
//

import Foundation

public class Formatters {
    public static let sharedInstance = Formatters()
    
    private let currencyFormatter = NumberFormatter()
    
    init() {
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.maximumFractionDigits = 2
        currencyFormatter.minimumFractionDigits = 2
        currencyFormatter.minimumIntegerDigits = 1
    }
    
    public func stringFromPrice(price: Double?, currencyCode: String) -> String? {
        guard let price = price else { return nil }
        currencyFormatter.currencyCode = currencyCode
        return currencyFormatter.string(from: NSNumber(value: price))
    }
}
