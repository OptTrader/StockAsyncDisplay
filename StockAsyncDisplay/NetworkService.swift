//
//  NetworkService.swift
//  StockAsyncDisplay
//
//  Created by Chris Kong on 1/1/17.
//  Copyright © 2017 Chris Kong. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias JSONDictionary = Dictionary<String, Any>
typealias StockModelCallback = ([Stock]) -> Void

final class NetworkService {
    
    lazy var session: URLSession = URLSession.shared

    func endpointForQuotes(symbols: Array<String>) -> String {
        let symbolsString: String = symbols.joined(separator: "\", \"")
        let query = "select * from yahoo.finance.quotes where symbol in (\"\(symbolsString) \")&format=json&diagnostics=true&env=store://datatables.org/alltableswithkeys&callback="
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)
        
        let endpoint = "https://query.yahooapis.com/v1/public/yql?q=" + encodedQuery!
        return endpoint
    }
    
    func fetchQuotesFromSymbols(symbols: Array<String>, completion: @escaping (_ results: [JSONDictionary]?, _ error: Error?) -> ()) {
        let urlString = self.endpointForQuotes(symbols: symbols)
        
        guard let url = URL(string: urlString) else {
            fatalError()
        }
        
        session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async(execute: { 
                do {
                    let jsonDict =  try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    let quotes = ((jsonDict.object(forKey: "query") as! NSDictionary).object(forKey: "results") as! NSDictionary).object(forKey: "quote") as! [JSONDictionary]
                    completion(quotes, nil)
                } catch let underlyingError {
                    completion(nil, underlyingError)
                }
            })
        }.resume()
    }
    
    func requestEquityData(symbols: Array<String>, onSuccess: StockModelCallback?, onError: ErrorCallback?) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let urlString = endpointForQuotes(symbols: symbols)
        Alamofire.request(urlString)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                guard response.result.error == nil else {
                    print(response.result.error!)
                    onError?(APIManagerError.network(error: response.result.error!))
                    return
                }
                
                guard let value = response.result.value else {
                    print("didn't get array of objects as JSON from API")
                    onError?(APIManagerError.objectSerialization(reason: "Did not get JSON dictionary in response"))
                    return
                }
                
                let json = JSON(value)
                guard let jsonArray = json["query"]["results"]["quote"].array else {
                    print("JSON not parsed as expected array")
                    onError?(APIManagerError.jsonError(reason: "JSON parsing error"))
                    return
                }
                
                let stockQuotesArray = jsonArray.flatMap { Stock(json: $0) }
                onSuccess?(stockQuotesArray)
        }
    }
    
}
