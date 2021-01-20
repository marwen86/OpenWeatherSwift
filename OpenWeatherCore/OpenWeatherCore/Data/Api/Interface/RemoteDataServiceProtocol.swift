//
//  RemoteDataServiceProtocol.swift
//  OpenWeather
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane.
//

import Foundation

protocol RemoteDataServiceProtocol {
    typealias RetrievalImageResult = Result<Data, RemoteDataError>
    typealias RetrievalForcastResult = Result<WeatherForecastItemsResponseDTO, RemoteDataError>
    typealias RetrievalWeatherResult = Result<CurrentWeatherResponseDTO, RemoteDataError>
    
    func fetchDailyForecast(endpoint: Requestable,
                  completion: @escaping (RetrievalForcastResult) -> Void)
    func fetch(endpoint: Requestable,
                  completion: @escaping (RetrievalWeatherResult) -> Void)
    func fetchImage(endpoint: Requestable,
                  completion: @escaping (RetrievalImageResult) -> Void)
}
