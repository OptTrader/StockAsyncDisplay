//
//  AppDelegate.swift
//  StockAsyncDisplay
//
//  Created by Chris Kong on 1/1/17.
//  Copyright © 2017 Chris Kong. All rights reserved.
//
//  http://www.appcoda.com/introduction-asyncdisplaykit-2-0/
//  http://asyncdisplaykit.org/docs/intelligent-preloading.html
//  http://asyncdisplaykit.org/docs/automatic-layout-examples-2.html

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = UIColor.white
        
        let stockFeedVC = StockFeedViewController()
        let networkService = NetworkService()
        
        let feedDataManager = FeedDataManager(networkService: networkService)
        let interactor = StockFeedInteractor()
        interactor.feedDataManager = feedDataManager
        interactor.output = stockFeedVC
        
        stockFeedVC.handler = interactor
        
        let stockFeedNavCtrl = UINavigationController(rootViewController: stockFeedVC)
        window.rootViewController = stockFeedNavCtrl
        
        window.makeKeyAndVisible()
        self.window = window
        
        applyStyles()
        
        return true
    }
    
    private func applyStyles() {
        let navigationBar = UINavigationBar.appearance()
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: ColorScheme.navigationBarForegroundColor ?? UIColor.white,
                                             NSFontAttributeName: Font.navigationBar]
        navigationBar.tintColor = ColorScheme.navigationBarForegroundColor
        navigationBar.barTintColor = ColorScheme.navigationBarBackgroundColor
    }

}
