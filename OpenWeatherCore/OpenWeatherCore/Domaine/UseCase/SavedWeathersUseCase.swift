//
//  CurrentWeathersUseCase.swift
//  OpenWeatherCore
//
//  Created by Youssef Marouane on 14/01/2021.
//

import Foundation
public protocol SavedWeathersUseCaseProtocol {
    typealias result = Swift.Result<[SearchSavedWeatherItem], Error>
    func execute(completion: @escaping (result) -> Void)
}

class SavedWeathersUseCase: SavedWeathersUseCaseProtocol {
    
    private let repository: CurrentWeatherRepository
    
    init(repository: CurrentWeatherRepository) {
        
        self.repository = repository
    }
    
    func execute(completion: @escaping (result) -> Void) {
        self.repository.fetchAll(cached: completion, completion: completion)
    }
}
