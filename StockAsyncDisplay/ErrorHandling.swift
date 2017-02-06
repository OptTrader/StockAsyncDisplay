//
//  ErrorHandling.swift
//  StockAsyncDisplay
//
//  Created by Chris Kong on 2/6/17.
//  Copyright © 2017 Chris Kong. All rights reserved.
//

import Foundation

typealias ErrorCallback = (Error) -> Void

enum APIManagerError: Error {
    case network(error: Error)
    case apiProvidedError(reason: String)
    case objectSerialization(reason: String)
    case jsonError(reason: String)
}
