//
//  ServiceBuilder.swift
//  OpenWeatherCore
//
//  Created by Youssef Marouane.
//

import Foundation
final class ServicesBuilder {
    
    let apiConfiguration: ApiConfiguration
    init(apiConfiguration: ApiConfiguration) {
        self.apiConfiguration = apiConfiguration
    }
    
    // MARK: - Network
    lazy var apiDataTransferService: RemoteDataServiceProtocol = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: apiConfiguration.apiBaseURL)!,
                                          queryParameters: ["appid": apiConfiguration.apiKey])
        
        let apiDataNetwork = DefaultNetworkService(config: config)
        return RemoteDataService(with: apiDataNetwork)
    }()
    
    lazy var imageDataTransferService: RemoteDataServiceProtocol = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: apiConfiguration.iconBaseURL)!)
        let imagesDataNetwork = DefaultNetworkService(config: config)
        return RemoteDataService(with: imagesDataNetwork)
    }()
    
    lazy var imageDataStorage: ImageStorage = {
        DefaultImageStorage(cache: NSCache<NSString, NSData>())
    }()
    
    lazy var currentWeatherDataStorage: CurrentWeatherResponseStorage = {
        return CoreDataCurrentWeatherResponseStorage(dataStorage: CoreDataStorageService.shared)
    }()
    
    lazy var forecastDataStorage: ForecastWeatherResponseStorage = {
        return CoreDataForecastResponseDataStorage(dataStorage: CoreDataStorageService.shared)
    }()
}
