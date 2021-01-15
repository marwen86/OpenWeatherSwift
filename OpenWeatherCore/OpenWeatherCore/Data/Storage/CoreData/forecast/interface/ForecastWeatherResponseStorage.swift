//
//  ForecastCurrentWeatherResponseStorage.swift
//  OpenWeather
//
//  Created by Youssef Marouane on 13/01/2021.
//  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation

protocol ForecastWeatherResponseStorage {
    
    typealias RetrievalResult = Swift.Result<[WeatherForeCastItemDTO], Error>
    typealias InsertionResult = Swift.Result<Void, Error>
    
    func retrieve(with requestDTO: ForecastWeatherRequestDTO,
               completion: @escaping (RetrievalResult) -> Void)
    func insert(item: WeatherForecastItemsResponseDTO,
                requestDTO: ForecastWeatherRequestDTO,
                completion:  @escaping (InsertionResult) -> Void)
}
