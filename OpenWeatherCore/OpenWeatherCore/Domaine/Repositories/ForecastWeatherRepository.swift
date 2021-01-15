//
//  ForecastWeatherRepository.swift
//  OpenWeather
//
//  Created by Youssef Marouane on 13/01/2021.
//  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation
protocol ForecastWeatherRepository {
    typealias fetchResult = Swift.Result<[ForecastItem], Error>
    
    func fetch(query: ForecastWeatherQuery,
               cached: @escaping (fetchResult) -> Void,
               completion: @escaping (fetchResult) -> Void)
}
