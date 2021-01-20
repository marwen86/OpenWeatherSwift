//
//  DefaultPosterImagesRepository.swift
//  CodawayGen
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane.
//

import Foundation

class DefaultPosterImagesLoader: PosterImagesLoader {
    
    private let local: ImageStorage
    private let remoteService: RemoteDataServiceProtocol
    
    init(dataRemoteService: RemoteDataServiceProtocol, local: ImageStorage) {
        self.remoteService = dataRemoteService
        self.local = local
    }
    
    func fetch(with icon: String, completion: @escaping (fetchResult) -> Void) {
        let endPoint = ApiGenerator.getWeatherIcon(icon: icon)
        remoteService.fetchImage(endpoint: endPoint) { result in
            switch result {
            case .failure:
                fetchLocalData()
            case .success(let data):
                completion(.success(data))
                self.local.insert(data, for: icon) { _ in
                }
            }
        }
        
        func fetchLocalData() {
            self.local.retrieve(dataForURL: icon) { result in
                switch result {
                case let .success(data):
                    guard let data = data else {
                        return
                    }
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
