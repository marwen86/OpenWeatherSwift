//
//  CoreDataMediaStorage.swift
//  CodawayGen
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane.
//

import Foundation
import CoreData

class CoreDataForecastResponseDataStorage: ForecastWeatherResponseStorage {
    
    let dataStorage: CoreDataStorageService
    init(dataStorage: CoreDataStorageService) {
        self.dataStorage = dataStorage
    }
    
    private func fetchRequest(for requestDto: ForecastWeatherRequestDTO) -> NSFetchRequest<WeatherForecastRequestEntity> {
        let request: NSFetchRequest = WeatherForecastRequestEntity.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@ AND %K = %d",
                                        #keyPath(WeatherForecastRequestEntity.query), requestDto.query,
                                        #keyPath(WeatherForecastRequestEntity.count), requestDto.count)
        return request
    }
    
    func retrieve(with requestDTO: ForecastWeatherRequestDTO,
                  completion: @escaping (RetrievalResult) -> Void) {
        dataStorage.performBackgroundTask { (context) in
            do {
                let fetchRequest = self.fetchRequest(for: requestDTO)
                guard let requestEntity = try context.fetch(fetchRequest).first,
                      let response = requestEntity.response,
                      let timestamp = response.timestamp,
                      FeedCachePolicy.validate(timestamp, against: Date()) else {
                    completion(.success([]))
                    return
                }
                
                completion(.success(response.toDTO().list))
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
            }
        }
    }
    
    func insert(item: WeatherForecastItemsResponseDTO,
                requestDTO: ForecastWeatherRequestDTO,
                completion:  @escaping (InsertionResult) -> Void) {
        
        self.dataStorage.performBackgroundTask { (context) in
            do {
                try self.abortForecastData(requestDTO: requestDTO) { _ in
                    do {
                        let requestEntity = requestDTO.toEntity(in: context)
                        requestEntity.response = item.toEntity(in: context)
                        try context.save()
                        completion(.success(()))
                    } catch {
                        completion(.failure(error))
                        debugPrint("CoreDataMoviesResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
                    }
                }
            } catch {
                completion(.failure(error))
                debugPrint("CoreDataMoviesResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }
    
    private func abortForecastData(requestDTO: ForecastWeatherRequestDTO ,
                                   completion: @escaping (Result<Bool, Error>) -> Void) throws {
        dataStorage.performBackgroundTask { (context) in
            do {
                let fetchRequest = self.fetchRequest(for: requestDTO)
                let requestEntity = try context.fetch(fetchRequest)
                for item in requestEntity {
                    context.delete(item)
                }
                try context.save()
                completion(.success(true))
            } catch {
                completion(.failure(error))
            }
        }
    }
}

