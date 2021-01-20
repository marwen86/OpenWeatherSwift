//
//  CurrentWeatherItem+Base.swift
//  OpenWeatherCoreTests
//
//  Created by Youssef Marouane.
//

import Foundation
import OpenWeatherCore

extension CurrentWeatherItem : Equatable {
    public static func == (lhs: CurrentWeatherItem, rhs: CurrentWeatherItem) -> Bool {
        return true
    }
    
    static func base(weather: [WeatherItem] = [],
                     visibility: Int = 0,
                     clouds: Int = 0,
                     temp: Double = 0,
                     feelsLike: Double = 0,
                     tempMin: Double = 0,
                     tempMax: Double = 0,
                     pressure: Int = 0,
                     humidity: Int = 0,
                     speed: Double = 0,
                     deg: Int = 0) -> CurrentWeatherItem {
        
     return CurrentWeatherItem(weather: weather, visibility: visibility, clouds: clouds, temp: temp, feelsLike: feelsLike, tempMin: tempMin, tempMax: tempMax, pressure: pressure, humidity: humidity, speed: speed, deg: deg)
    }
}
