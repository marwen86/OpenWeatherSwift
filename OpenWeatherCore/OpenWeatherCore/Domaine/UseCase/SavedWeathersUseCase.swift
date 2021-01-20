//
//  CurrentWeathersUseCase.swift
//  OpenWeatherCore
//
//  Created by Youssef Marouane.
//

import Foundation
public protocol SavedWeathersUseCaseProtocol {
    typealias result = Swift.Result<[SearchSavedWeatherItem], Error>
    func execute(completion: @escaping (result) -> Void)
}

class SavedWeathersUseCase: SavedWeathersUseCaseProtocol {
    
    private let repository: CurrentWeatherLoader
    
    init(repository: CurrentWeatherLoader) {
        
        self.repository = repository
    }
    
    func execute(completion: @escaping (result) -> Void) {
        self.repository.fetchAll(cached: completion, completion: completion)
    }
}
