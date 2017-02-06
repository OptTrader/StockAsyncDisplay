
//
//  StockCellNode.swift
//  StockAsyncDisplay
//
//  Created by Chris Kong on 1/11/17.
//  Copyright © 2017 Chris Kong. All rights reserved.
//

import AsyncDisplayKit

final class StockCellNode: ASCellNode {
    fileprivate var _symbolLabel: ASTextNode!
    fileprivate var _companyLabel: ASTextNode!
    fileprivate var _priceLabel: ASTextNode!
    
    init(stock: Stock) {
        super.init()
        
        _symbolLabel = createLayerBackedTextNode(attributedString: stock.symbol.attributedString(fontSize: 18,
                                                                                                 color: ColorScheme.cellPrimaryTextColor!))
        
        _companyLabel = createLayerBackedTextNode(attributedString: stock.companyName.attributedString(fontSize: 18,
                                                                                                       color: ColorScheme.cellSecondaryTextColor!))
        
        if let lastTradePrice = stock.lastTradePrice {
            let lastTradeString = Formatters.sharedInstance.stringFromPrice(price: lastTradePrice, currencyCode: "USD")
            _priceLabel = createLayerBackedTextNode(attributedString: (lastTradeString?.attributedString(fontSize: 18, color: ColorScheme.priceTextColor))!)
        }
        
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let symbolCompanyStack = ASStackLayoutSpec.vertical()
        symbolCompanyStack.style.flexShrink = 1.0
        symbolCompanyStack.style.flexGrow = 1.0
        
        if _companyLabel.attributedText != nil {
            symbolCompanyStack.children = [_symbolLabel, _companyLabel]
        } else {
            symbolCompanyStack.children = [_symbolLabel]
        }
        
        let headerStackSpec = ASStackLayoutSpec(direction: .horizontal,
                                                spacing: 40,
                                                justifyContent: .start,
                                                alignItems: .center,
                                                children: [symbolCompanyStack, _priceLabel])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 15), child: headerStackSpec)
    }
    
    // MARK: Helper
    
    fileprivate func createLayerBackedTextNode(attributedString: NSAttributedString) -> ASTextNode {
        let textNode = ASTextNode()
        textNode.isLayerBacked = true
        textNode.attributedText = attributedString
        
        return textNode
    }

}
