//
//  WeatherDetailViewPresenter.swift
//  OpenWeather
//
//  Created by Youssef Marouane on 19/01/2021.
//  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation
import UIKit
import OpenWeatherCore

public struct CurrentWeatherItemViewModel {
    let description: String
    let icon: String
    let visibility: String
    let clouds: String
    let temp: String
    let feelsLike: String
    let tempMin: String
    let tempMax: String
    let pressure: String
    let humidity: String
    let speed: String
    let deg: String
}

public protocol WeatherDetailViewPresenterProtocol {
    func interactor(_ interactor: DetailViewInteractorProtocol, didFetch image: Data)
    func interactor(_ interactor: DetailViewInteractorProtocol, didFetch item: CurrentWeatherItem)
}

public class WeatherDetailViewPresenter {
    
    public init(view: WeatherDetailViewProtocol? = nil) {
        self.view = view
    }

    public weak var view: WeatherDetailViewProtocol?
    private func buildViewModel(item: CurrentWeatherItem) -> CurrentWeatherItemViewModel {
        // create viewModel and update view
        CurrentWeatherItemViewModel(description: item.weather.first?.description ?? "",
                                    icon: item.weather.first?.icon ?? "",
                                    visibility: "\(String(item.visibility)) km",
                                    clouds: String(item.clouds),
                                    temp: "\(String(format:"%.0f", item.temp.kelvinToDeg))°",
                                    feelsLike: "\(String(item.feelsLike))°",
                                    tempMin: "\(String(format:"%.0f", item.tempMin.kelvinToDeg))°",
                                    tempMax: "\(String(format:"%.0f", item.tempMax.kelvinToDeg))°",
                                    pressure: "\(String(item.pressure)) hPa",
                                    humidity: "\(String(item.humidity)) %",
                                    speed: "\(String(item.speed)) Km/h" ,
                                    deg: "\(String(item.deg))°")
    }
}

extension WeatherDetailViewPresenter: WeatherDetailViewPresenterProtocol {
    public func interactor(_ interactor: DetailViewInteractorProtocol, didFetch image: Data) {
        //update icon view
        DispatchQueue.main.async {
            self.view?.set(iconWeather: UIImage(data: image))
        }
    }
    
    public func interactor(_ interactor: DetailViewInteractorProtocol, didFetch item: CurrentWeatherItem) {
        DispatchQueue.main.async {
            self.view?.set(currentWeather: self.buildViewModel(item: item))
        }
    }
}

