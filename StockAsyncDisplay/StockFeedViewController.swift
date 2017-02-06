//
//  StockFeedViewController.swift
//  StockAsyncDisplay
//
//  Created by Chris Kong on 1/1/17.
//  Copyright © 2017 Chris Kong. All rights reserved.
//

import AsyncDisplayKit

class StockFeedViewController: ASViewController<ASTableNode>, StockFeedInteractorOutput {
    
    var handler: StockFeedInteractorInput?
    var _activityIndicatorView: UIActivityIndicatorView!
    var _dataProvider : StockFeedTableDataProvider!
    var _tableNode: ASTableNode
    
    init() {
        _tableNode = ASTableNode()
        super.init(node: _tableNode)
        setInitialState()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        _activityIndicatorView.hidesWhenStopped = true
        _activityIndicatorView.sizeToFit()
        
        var refreshRect = _activityIndicatorView.frame
        refreshRect.origin = CGPoint(x: (view.bounds.size.width - _activityIndicatorView.frame.width) / 2.0,
                                     y: _activityIndicatorView.frame.midY
        )
        
        _activityIndicatorView.frame = refreshRect
        view.addSubview(_activityIndicatorView)
        
        _tableNode.view.allowsSelection = false
        _tableNode.view.separatorStyle = .none
        _tableNode.view.backgroundColor = ColorScheme.primaryBackgroundColor
        
        _activityIndicatorView.startAnimating()
        handler?.findStocks()
        
    }
    
    func foundStockItems(_ stocks: [Stock]?, error: Error?) {
        guard error == nil else { return }
        
        _dataProvider.insertNewStocksInTableView(stocks!)
        _activityIndicatorView.stopAnimating()
    }
    
    // MARK: Helper Method
    
    func setInitialState() {
        title = "Uptick Watchlist"
        
        _dataProvider = StockFeedTableDataProvider()
        _dataProvider._tableNode = _tableNode
        _tableNode.dataSource = _dataProvider
    }
}
