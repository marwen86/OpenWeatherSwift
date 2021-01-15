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
    
    private func updateCurrentWeather(list: [SearchSavedWeatherItem],
                                      completion: @escaping (fetchAllResult) -> Void) {
        func getRemoteData(city: String, block: @escaping () -> Void) {
            let requestDTO = WeatherRequestDTO(query: city)
            let endPoint = ApiGenerator.getCurrentWeather(with: requestDTO)
            remote.fetch(endpoint: endPoint) { result in
                switch result {
                case .failure:
                    block()
                case .success(let result):
                    self.local.insert(item: result, requestDTO: requestDTO, completion: {  _ in
                        block()
                    })
                }
            }
        }
        
        let querys = list.map { $0.city }.compactMap { $0 }
        let group = DispatchGroup()
        querys.forEach { city in
            group.enter()
            getRemoteData(city: city) {
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            self.local.retrieveAll(completion: { result in
                switch result{
                case .success(let items):
                    let items = items.map { $0.toDomaine() }
                    completion(.success(items))
                case .failure(let error):
                    completion(.failure(error))
                }
            })
        }
        
        
    }
    
    func fetchAll(cached: @escaping (fetchAllResult) -> Void,
                  completion: @escaping (fetchAllResult) -> Void) {
        
        // only fetch from local storage
        self.local.retrieveAll(completion: { [weak self] result in
            guard let self = self else { return }
            switch result{
            case .success(let items):
                let items = items.map { $0.toDomaine() }
                cached(.success(items))
                self.updateCurrentWeather(list: items, completion: completion)
            case .failure(let error):
                cached(.failure(error))
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
