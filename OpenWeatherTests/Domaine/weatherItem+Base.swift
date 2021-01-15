//
//  weatherItem+Base.swift
//  OpenWeatherTests
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane. All rights reserved.  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation
extension WeatherItem: Equatable {
    static func == (lhs: WeatherItem, rhs: WeatherItem) -> Bool {
        return true
    }
    
    
    static func base(pressure: Double = 0,
                     humidity: Double = 0,
                     speed: Double = 0,
                     deg: Int = 0,
                     clouds: Int = 0,
                     snow: Double = 0,
                     weather: [WeatherItem.weather] = [],
                     temp: WeatherItem.Temp? = nil) -> WeatherItem {
        
     return WeatherItem(pressure: pressure,
                        humidity: humidity,
                        speed: speed,
                        deg: deg,
                        clouds: clouds,
                        snow: snow,
                        weather: weather,
                        temp: temp)
    }
}
