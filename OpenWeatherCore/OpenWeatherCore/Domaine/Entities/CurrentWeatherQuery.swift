//
//  CurrentWeatherRequest.swift
//  OpenWeather
//
//  Created by Youssef Marouane.
//  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation
public struct CurrentWeatherQuery {
    public init(query: String) {
        self.query = query
    }
    
    public let query : String
}
