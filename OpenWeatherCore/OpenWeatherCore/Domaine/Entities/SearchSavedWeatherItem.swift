//
//  SearchSavedWeatherItem.swift
//  OpenWeather
//
//  Created by Youssef Marouane on 13/01/2021.
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
