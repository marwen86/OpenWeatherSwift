//
//  SearchWeatherDataUseCase.swift
//  OpenWeather
//
//  Created by Youssef Marouane
//  Copyright © 2020 Youssef Marouane. All rights reserved.
//

import Foundation
public protocol AddWeatherUseCaseProtocol {
    typealias result = Result<CurrentWeatherItem?, Error>
    func execute(city: String,
                 completion: @escaping (result) -> Void)
}

class AddWeatherUseCase: AddWeatherUseCaseProtocol {
    
    private let repository: CurrentWeatherLoader
    
    init(repository: CurrentWeatherLoader) {
        
        self.repository = repository
    }
    
    func execute(city: String,
                 completion: @escaping (result) -> Void) {
        let query = CurrentWeatherQuery(query: city)
        self.repository.fetch(query: query, completion: completion)
    }
}
