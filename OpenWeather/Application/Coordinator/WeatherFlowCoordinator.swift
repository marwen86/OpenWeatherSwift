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
    
    private func showDetail(city: String) {
        let view = makeDetailViewController(city: city)
        self.navigationController.pushViewController(view, animated: true)
    }
    
    private func showForecast(city: String) {
        let view = makeDailyForecastController(city: city)
        let navigationController = UINavigationController(rootViewController: view)
        self.navigationController.present(navigationController, animated: true, completion: nil)
    }
    
    private func makeDailyForecastController(city: String) -> DailyForecastViewController {
        let view = ViewsBuilder.makeDailyForecastView(useCases: useCases, city: city)
        return view
    }
    
    private func makeCitiesViewController() -> CitiesListViewController {
        let view = ViewsBuilder.makeCitiesView(useCases: useCases)
        view.onShowDetail = { city in
            self.showDetail(city: city)
        }
        return view
    }
    
    private func makeDetailViewController(city: String) -> DetailViewController {
        let view = ViewsBuilder.makeDetail(useCases: useCases, city: city)
        view.onShowForeCast = { city in
            self.showForecast(city: city)
        }
        return view
    }
}
