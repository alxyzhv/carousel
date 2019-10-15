//
//  AppDelegate.swift
//  Carousel
//
//  Created by Alexey Zhulikov on 11/10/2019.
//  Copyright © 2019 Alexey Zhulikov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UIStoryboard.instantiate(ofType: MainViewController.self)
        return true
    }

}
