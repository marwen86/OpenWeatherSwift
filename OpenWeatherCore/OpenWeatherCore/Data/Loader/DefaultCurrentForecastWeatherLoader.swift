//
//  DefaultCurrentForecastWeather.swift
//  OpenWeather
//
//  Created by Youssef Marouane.
//  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation
class DefaultCurrentForecastWeatherLoader: ForecastWeatherLoader {
    
    private let remoteService: RemoteDataServiceProtocol
    private let localService: ForecastWeatherResponseStorage
    init(dataRemoteService: RemoteDataServiceProtocol, dataLocalService: ForecastWeatherResponseStorage) {
        self.remoteService = dataRemoteService
        self.localService = dataLocalService
    }
    
    func fetch(query: ForecastWeatherQuery,
               cached: @escaping (fetchResult) -> Void,
               completion: @escaping (fetchResult) -> Void) {
        
        let requestDTO = ForecastWeatherRequestDTO(query: query.query, count: query.count)
        let endPoint = ApiGenerator.getWeatherForecast(with: requestDTO)
        remoteService.fetchDailyForecast(endpoint: endPoint) { result in
            switch result {
            case .failure:
                fetchLocalData()
            case .success(let result):
                let list = result.list.map { $0.toDomaine()}
                self.localService.insert(item: result, requestDTO: requestDTO, completion: { result in
                    completion(.success(list))
                })
            }
        }
        
        func fetchLocalData() {
            self.localService.retrieve(with: requestDTO, completion: { result in
                switch result{
                case .success(let items):
                    completion(.success(items.map { $0.toDomaine() }))
                case .failure(let error):
                    completion(.failure(error))
                }
            })
        }
    }
}
