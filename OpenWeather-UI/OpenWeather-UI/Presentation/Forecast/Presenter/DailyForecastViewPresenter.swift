//
//  DailyForecastViewPresenter.swift
//  OpenWeather
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane.
//

import Foundation
import OpenWeatherCore
    
public  struct WeatherItemViewModel {
    let maxTemp: String
    let minTemp : String
    let humidity : String
    let image: String?
    let day: String
}

public  protocol DailyForecastPresenterProtocol : class {
    func interactor(_ interactor: HomeInteractorProtocol, didFetch objects: [ForecastItem])
    func interactor(_ interactor: HomeInteractorProtocol, didFailWith error: Error)
}

public class DailyForecastViewPresenter {
    
    public init(view: DailyForecastViewProtocol? = nil) {
        self.view = view
    }
    

    public weak var view: DailyForecastViewProtocol?
    private func buildViewModel(item: ForecastItem, index: Int) -> WeatherItemViewModel {
        let day = Date().DatebyAddingDay(day: index).dayInWeek
        return  WeatherItemViewModel(maxTemp: "\(String(format:"%.0f", item.temp?.max.kelvinToDeg ?? 0))°",
                                    minTemp: "\(String(format:"%.0f", item.temp?.min.kelvinToDeg ?? 0))°",
                                    humidity: "\(String(format:"%.0f", item.humidity))%",
                                    image: item.weather.first?.icon,
                                    day: day)
    }
}

extension DailyForecastViewPresenter: DailyForecastPresenterProtocol {
    public func interactor(_ interactor: HomeInteractorProtocol, didFetch objects: [ForecastItem]) {
        DispatchQueue.main.async { self.view?.set(ViewModels:  objects.enumerated().map {
            self.buildViewModel(item: $1, index: $0)
        })
        }
    }
    
    public func interactor(_ interactor: HomeInteractorProtocol, didFailWith error: Error) {
        DispatchQueue.main.async { self.view?.set(error: error.localizedDescription) }
    }
}
