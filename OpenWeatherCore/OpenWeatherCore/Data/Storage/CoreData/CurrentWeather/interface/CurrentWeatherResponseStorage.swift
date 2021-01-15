//
//  CurrentWeatherResponseStorage.swift
//  OpenWeather
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane. All rights reserved.  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation
protocol CurrentWeatherResponseStorage {
    typealias RetrievalResult = Swift.Result<CurrentWeatherResponseDTO?, Error>
    typealias RetrievalAllResult = Swift.Result<[SearchSavedWeatherResponseDTO], Error>
    typealias InsertionResult = Swift.Result<Void, Error>

    func insert(item: CurrentWeatherResponseDTO,
                requestDTO: WeatherRequestDTO,
                completion: @escaping (InsertionResult) -> Void)
    func retrieve(with requestDTO: WeatherRequestDTO,
                                   completion: @escaping (RetrievalResult) -> Void)
    func retrieveAll(completion: @escaping (RetrievalAllResult) -> Void)
}
