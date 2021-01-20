//
//  ForecastWeatherRepository.swift
//  OpenWeather
//
//  Created by Youssef Marouane.
//  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation
protocol ForecastWeatherLoader {
    typealias fetchResult = Swift.Result<[ForecastItem], Error>
    
    func fetch(query: ForecastWeatherQuery,
               cached: @escaping (fetchResult) -> Void,
               completion: @escaping (fetchResult) -> Void)
}
