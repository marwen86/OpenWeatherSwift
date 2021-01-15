//
//  HomeInteractor.swift
//  OpenWeather
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane. All rights reserved.  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation

protocol HomeInteractorProtocol {
    func fetchWeatherData(city: String)
}

class HomeInteractor: HomeInteractorProtocol {
    private let forecastUseCase: ForecastUseCaseProtocol
    var presenter: DailyForecastPresenterProtocol?
    
    init(forecastUseCase: ForecastUseCaseProtocol) {
        self.forecastUseCase = forecastUseCase
    }
    
    func fetchWeatherData(city: String) {
        func hundleErrorResponse(error: Error) {
            //call error Delegate
            presenter?.interactor(self, didFailWith: error)
        }
        
        func handleSuccessResponse(items: [ForecastItem]) {
            //call delegate to refresh VC
            presenter?.interactor(self, didFetch: items)
        }
        
        
        self.forecastUseCase.execute(query: city, count: 5, cached: { result in
            do {
                let items = try result.get()
                handleSuccessResponse(items: items)
            } catch {
                hundleErrorResponse(error: error)
            }
        }) { result in
            do {
                let items = try result.get()
                handleSuccessResponse(items: items)
            } catch {
                hundleErrorResponse(error: error)
            }
        }
    }
}
