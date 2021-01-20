//
//  ForecastWeatherQuery.swift
//  OpenWeather
//
//  Created by Youssef Marouane.
//  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation
public struct ForecastWeatherQuery {
    public init(query: String, count: Int) {
        self.query = query
        self.count = count
    }
    
    public let query: String
    public let count: Int
}
