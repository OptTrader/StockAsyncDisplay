//
//  StockFeedTableDataProvider.swift
//  StockAsyncDisplay
//
//  Created by Chris Kong on 1/11/17.
//  Copyright © 2017 Chris Kong. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class StockFeedTableDataProvider: NSObject, ASTableDataSource {

    var _stocks: [Stock]?
    weak var _tableNode: ASTableNode?
    
    // MARK: Table Data Source
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return _stocks?.count ?? 0
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let stock = _stocks![indexPath.row]
        let cellNodeBlock = { () -> ASCellNode in
            return StockCellNode(stock: stock)
        }
        
        return cellNodeBlock
    }
    
    // MARK: Helper
    
    func insertNewStocksInTableView(_ stocks: [Stock]) {
        _stocks = stocks
        
        let section = 0
        var indexPaths = [IndexPath]()
        stocks.enumerated().forEach { (row, stock) in
            let path = IndexPath(row: row, section: section)
            indexPaths.append(path)
        }
        _tableNode?.insertRows(at: indexPaths, with: .none)
    }
}
