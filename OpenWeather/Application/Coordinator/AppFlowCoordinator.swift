//
//  AppCoordinator.swift
//  CodawayGen
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane.
//

import Foundation
import UIKit

class AppFlowCoordinator {
    
    var navigationController: UINavigationController
    private let useCases: OpenWeather.UseCases
    private var childCoordinator = [Any]()
    init(navigationController: UINavigationController,
         useCases: OpenWeather.UseCases) {
        self.navigationController = navigationController
        self.useCases = useCases
    }
    
    func start() {

        let homeCoordinator = WeatherFlowCoordinator(navigationController: navigationController,
                                                     useCases: self.useCases)
        childCoordinator.append(homeCoordinator)
        homeCoordinator.start()
    }
}
