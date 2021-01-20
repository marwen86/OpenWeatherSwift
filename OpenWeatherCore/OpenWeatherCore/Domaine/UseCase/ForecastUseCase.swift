//
//  ForecasTUseCase.swift
//  OpenWeatherCore
//
//  Created by Youssef Marouane.
//

import Foundation
public protocol ForecastUseCaseProtocol {
    
    typealias result = Swift.Result<[ForecastItem], Error>
    func execute(query: String,
                 count: Int,
                 cached: @escaping (result) -> Void,
                 completion: @escaping (result) -> Void)
}

class ForecastUseCase: ForecastUseCaseProtocol {
    
    private let repository: ForecastWeatherLoader
    
    init(repository: ForecastWeatherLoader) {
        
        self.repository = repository
    }
    
    func execute(query: String,
                 count: Int,
                 cached: @escaping (result) -> Void,
                 completion: @escaping (result) -> Void) {
        let query = ForecastWeatherQuery(query: query, count: 5)
        self.repository.fetch(query: query, cached: cached, completion: completion)
    }
}
