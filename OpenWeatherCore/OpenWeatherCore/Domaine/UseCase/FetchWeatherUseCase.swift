//
//  FetchWeather.swift
//  OpenWeatherCore
//
//  Created by Youssef Marouane on 19/01/2021.
//

import Foundation
public protocol FetchWeatherUseCaseProtocol {
    
    typealias result = Swift.Result<CurrentWeatherItem?, Error>
    func execute(query: String,
                 completion: @escaping (result) -> Void)
}

class FetchWeatherUseCase: FetchWeatherUseCaseProtocol {

    private let repository: CurrentWeatherRepository
    
    init(repository: CurrentWeatherRepository) {
        
        self.repository = repository
    }
    
    func execute(query: String, completion: @escaping (result) -> Void) {
        let query = CurrentWeatherQuery(query: query)
        self.repository.fetch(query: query, completion: completion)
    }
}
