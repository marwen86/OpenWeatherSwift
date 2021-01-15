//
//  AppDelegate.swift
//  OpenWeather
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane. All rights reserved.  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import UIKit
import OpenWeatherCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appFlowCoordinator: AppFlowCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.setupAppearance()
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        
        window?.rootViewController = navigationController
        let appConfiguration = AppConfiguration()
        let useCases = OpenWeather.start(apiBaseUrl: appConfiguration.apiBaseURL,
                                            iconBaseUrl: appConfiguration.iconBaseURL,
                                            apiKey: appConfiguration.apiKey)
        appFlowCoordinator = AppFlowCoordinator(navigationController: navigationController, useCases: useCases)
        appFlowCoordinator?.start()
        window?.makeKeyAndVisible()
        return true
    }
    
    private func setupAppearance() {
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
}

