//
//  SearchIconWeatherUserCase.swift
//  OpenWeather
//
//  Created by Youssef Marouane
//  Copyright © 2020 Youssef Marouane. All rights reserved.
//

import Foundation

public protocol GetIconUseCaseProtocol {
    typealias result = Result<Data, Error>
    func execute(icon: String,
                 completion: @escaping (result) -> Void)
}

class GetIconUseCase: GetIconUseCaseProtocol {
    
    private let repository: PosterImagesLoader
    
    init(repository: PosterImagesLoader) {
        
        self.repository = repository
    }
    
    func execute(icon: String,
                 completion: @escaping (result) -> Void) {
        self.repository.fetch(with: icon, completion: completion)
    }
    
}
