//
//  weatherItem+Base.swift
//  OpenWeatherTests
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane.
//

import Foundation
import OpenWeatherCore

extension ForecastItem: Equatable {
    public static func == (lhs: ForecastItem, rhs: ForecastItem) -> Bool {
        return true
    }
    
    
    static func base(pressure: Double = 0,
                     humidity: Double = 0,
                     speed: Double = 0,
                     deg: Int = 0,
                     clouds: Int = 0,
                     snow: Double = 0,
                     weather: [WeatherItem] = [],
                     temp: Temp? = nil) -> ForecastItem {
        
     return ForecastItem(pressure: pressure,
                        humidity: humidity,
                        speed: speed,
                        deg: deg,
                        clouds: clouds,
                        weather: weather,
                        temp: temp)
    }
}
