//
//  CoreDataMediaStorage.swift
//  CodawayGen
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane. All rights reserved.  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation
import CoreData

class CoreDataCurrentWeatherResponseStorage: CurrentWeatherResponseStorage {
    
    let dataStorage: CoreDataStorageService
    init(dataStorage: CoreDataStorageService) {
        self.dataStorage = dataStorage
    }
    
    private func fetchRequest(for requestDto: WeatherRequestDTO) -> NSFetchRequest<CurrentWeatherRequestEntity> {
        let request: NSFetchRequest = CurrentWeatherRequestEntity.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@",
                                        #keyPath(CurrentWeatherRequestEntity.query), requestDto.query)
        return request
    }
    
    func retrieveAll(completion: @escaping (RetrievalAllResult) -> Void) {
        dataStorage.performBackgroundTask { (context) in
            do {
                let request: NSFetchRequest = CurrentWeatherRequestEntity.fetchRequest()
                let result = try context.fetch(request).map { SearchSavedWeatherResponseDTO(weather: $0.response?.toDTO(),
                                                                                            city: $0.query) }
                completion(.success(result))
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
                debugPrint("CoreDataMoviesResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }
    
    func insert(item: CurrentWeatherResponseDTO,
                requestDTO: WeatherRequestDTO,
                completion: @escaping (InsertionResult) -> Void) {
        do {
            try abortForecastData(requestDTO: requestDTO, completion: { result in
                self.dataStorage.performBackgroundTask { (context) in
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
            })
        } catch  {
            debugPrint("CoreDataMoviesResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
        }
        
    }
    
    func retrieve(with requestDTO: WeatherRequestDTO,
                  completion: @escaping (RetrievalResult) -> Void) {
        dataStorage.performBackgroundTask { (context) in
            do {
                let fetchRequest = self.fetchRequest(for: requestDTO)
                let requestEntity = try context.fetch(fetchRequest).first
                completion(.success(requestEntity?.response?.toDTO()))
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
            }
        }
    }
    
    private func abortForecastData(requestDTO: WeatherRequestDTO ,
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
