//
//  AppDelegate.swift
//  RxSplash
//
//  Created by killi8n on 30/09/2018.
//  Copyright © 2018 killi8n. All rights reserved.
//

import UIKit
import Kingfisher

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        let provider = ServiceProvider()
        let reactor = MainViewReactor(provider: provider)
        let mainViewController = MainViewController(reactor: reactor)
        let rootNavi = UINavigationController(rootViewController: mainViewController)
        window?.rootViewController = rootNavi
        window?.makeKeyAndVisible()
        
        return true
    }


}

