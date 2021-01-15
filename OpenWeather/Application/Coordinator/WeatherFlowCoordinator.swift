//
//  WeatherFlowCoordinator.swift
//  OpenWeather
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane. All rights reserved.  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation
import UIKit

protocol WeatherFlowCoordinatorProtocol {
    func start()
}

class WeatherFlowCoordinator: WeatherFlowCoordinatorProtocol {
        
    private let useCases: OpenWeather.UseCases
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController, useCases: OpenWeather.UseCases) {
        self.useCases = useCases
        self.navigationController = navigationController
    }
    
    func start() {
        let view = makeCitiesViewController()
        self.navigationController.pushViewController(view, animated: false)
    }
    
    private func showDetail() {
        let view = makeDetailViewController()
        self.navigationController.pushViewController(view, animated: true)
    }
    
    private func showForecast(city: String) {
        let view = makeDailyForecastController(city: city)
        self.navigationController.pushViewController(view, animated: true)
    }
    
    private func makeDailyForecastController(city: String) -> DailyForecastViewController {
        let view = ViewsBuilder.makeDailyForecastView(useCases: useCases, city: city)
        view.onShowDetail = { city in
            self.showDetail()
        }
        
        return view
    }
    
    private func makeCitiesViewController() -> CitiesListViewController {
        let view = ViewsBuilder.makeCitiesView(useCases: useCases)
        view.onShowForeCast = { city in
            self.showForecast(city: city)
        }
        return view
    }
    
    private func makeDetailViewController() -> DetailViewController {
        return ViewsBuilder.makeDetail()
    }
}
