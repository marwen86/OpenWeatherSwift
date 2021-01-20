//
//  UseCaseBuilder.swift
//  OpenWeatherCore
//
//  Created by Youssef Marouane.
//

import Foundation
final class UseCaseBuilder {
    let serviceBuilder: ServicesBuilder
    init(serviceBuilder: ServicesBuilder) {
        self.serviceBuilder = serviceBuilder
    }
    
    lazy var getIconUseCase: GetIconUseCaseProtocol = {
        let repository = DefaultPosterImagesLoader(dataRemoteService: serviceBuilder.imageDataTransferService, local: serviceBuilder.imageDataStorage)
        return GetIconUseCase(repository: repository)
    }()
    
    lazy var addWeatherUseCase: AddWeatherUseCaseProtocol = {
        let repository = DefaultCurrentWeatherLoader(dataRemoteService: serviceBuilder.apiDataTransferService,
                                                         dataLocalService: serviceBuilder.currentWeatherDataStorage)
        return AddWeatherUseCase(repository: repository)
    }()
    
    lazy var savedWeathersUseCase: SavedWeathersUseCaseProtocol = {
        let repository = DefaultCurrentWeatherLoader(dataRemoteService: serviceBuilder.apiDataTransferService,
                                                         dataLocalService: serviceBuilder.currentWeatherDataStorage)
        return SavedWeathersUseCase(repository: repository)
    }()
    
    lazy var forecastUseCase: ForecastUseCaseProtocol = {
        let repository = DefaultCurrentForecastWeatherLoader(dataRemoteService: serviceBuilder.apiDataTransferService,
                                                       dataLocalService: serviceBuilder.forecastDataStorage)
        return ForecastUseCase(repository: repository)
    }()
    
    lazy var currentWeatherUseCase: FetchWeatherUseCaseProtocol = {
        let repository = DefaultCurrentWeatherLoader(dataRemoteService: serviceBuilder.apiDataTransferService,
                                                         dataLocalService: serviceBuilder.currentWeatherDataStorage)
        return FetchWeatherUseCase(repository: repository)
    }()
    
}
