//
//  SearchSavedWeatherItem.swift
//  OpenWeather
//
//  Created by Youssef Marouane.
//  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation
public struct SearchSavedWeatherItem {
    public init(weather: CurrentWeatherItem?, city: String?) {
        self.weather = weather
        self.city = city
    }
    
    public let weather: CurrentWeatherItem?
    public let city: String?
}
