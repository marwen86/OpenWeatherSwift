//
//  RemoteDataService.swift
//  OpenWeather
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane. All rights reserved.  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation

public enum RemoteDataError: Error {
    case noResponse
    case parsing(Error)
    case generic(Error)
}

class RemoteDataService: RemoteDataServiceProtocol {

    private let network: NetworkService
    public init(with networkService: NetworkService) {
        self.network = networkService
    }
    
    func fetch(endpoint: Requestable,
                  completion: @escaping (RetrievalWeatherResult) -> Void) {
        _ = self.network.request(endpoint: endpoint) { result in
              switch result {
              case .success(let data):
                  guard let data = data else {
                    completion(.failure(.noResponse))
                    return
                  }
                  do {
                    let result = try JSONDecoder().decode(CurrentWeatherResponseDTO.self,
                                                          from: data)
                    DispatchQueue.main.async { completion(.success(result)) }
                  } catch {
                    completion(.failure(.parsing(error)))
                  }
                 
              case .failure(let error):
                completion(.failure(.generic(error)))
              }
          }
        
    }
    
    func fetchDailyForecast(endpoint: Requestable,
                  completion: @escaping (RetrievalForcastResult) -> Void) {
           
        _ = self.network.request(endpoint: endpoint) { result in
              switch result {
              case .success(let data):
                  guard let data = data else {
                    completion(.failure(.noResponse))
                    return 
                  }
                  do {
                    let result = try JSONDecoder().decode(WeatherForecastItemsResponseDTO.self,
                                                                                   from: data)
                    DispatchQueue.main.async { completion(.success(result)) }
                  } catch {
                    completion(.failure(.parsing(error)))
                  }
                 
              case .failure(let error):
                completion(.failure(.generic(error)))
              }
          }
    }
    
    func fetchImage(endpoint: Requestable,
                  completion: @escaping (RetrievalImageResult) -> Void) {
       
        _ = self.network.request(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                guard let data = data else {
                  completion(.failure(.noResponse))
                  return
                }
                
                DispatchQueue.main.async { completion(.success(data))}
            case .failure(let error):
              completion(.failure(.generic(error)))
            }
        }
    }
}
