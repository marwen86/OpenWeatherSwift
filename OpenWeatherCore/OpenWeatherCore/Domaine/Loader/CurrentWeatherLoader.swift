//
//  WeatherRepository.swift
//  OpenWeather
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane. All rights reserved.  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation
protocol CurrentWeatherLoader {
    typealias fetchResult = Swift.Result<CurrentWeatherItem?, Error>
    typealias fetchAllResult = Swift.Result<[SearchSavedWeatherItem], Error>
    
    func fetch(query: CurrentWeatherQuery,
                             completion: @escaping (fetchResult) -> Void)
    func fetchAll(cached: @escaping (fetchAllResult) -> Void,
                  completion: @escaping (fetchAllResult) -> Void)
}