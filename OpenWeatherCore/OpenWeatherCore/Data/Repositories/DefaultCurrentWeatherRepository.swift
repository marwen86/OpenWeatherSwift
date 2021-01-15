//
//  DefaultMediaRepository.swift
//  CodawayGen
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane. All rights reserved.  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation

class DefaultCurrentWeatherRepository: CurrentWeatherRepository {
    
    private let remote: RemoteDataServiceProtocol
    private let local: CurrentWeatherResponseStorage
    init(dataRemoteService: RemoteDataServiceProtocol, dataLocalService: CurrentWeatherResponseStorage) {
        self.remote = dataRemoteService
        self.local = dataLocalService
    }
    
    func fetchAll(completion: @escaping (fetchAllResult) -> Void) {
        // only fetch from local storage
        self.local.retrieveAll(completion: { result in
            switch result{
            case .success(let items):
                completion(.success(items.map { $0.toDomaine() }))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func fetch(query: CurrentWeatherQuery,
               completion: @escaping (fetchResult) -> Void) {
        
        // call remote find only if local storage return empty or nil
        let requestDTO = WeatherRequestDTO(query: query.query)
        func getRemoteData() {
            let endPoint = ApiGenerator.getCurrentWeather(with: requestDTO)
            remote.fetch(endpoint: endPoint) { result in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let result):
                    self.local.insert(item: result, requestDTO: requestDTO, completion: {  _ in
                        completion(.success(result.toDomaine()))
                    })
                }
            }
        }
        
        self.local.retrieve(with: requestDTO,
                            completion: { result in
                                switch result{
                                case .success(let item):
                                    guard let item = item else {
                                        getRemoteData()
                                        return
                                    }
                                    completion(.success(item.toDomaine()))
                                case .failure(let error):
                                    completion(.failure(error))
                                    
                                }
                            })
        
    }
}
