//
//  UseCaseBuilder.swift
//  OpenWeatherCore
//
//  Created by Youssef Marouane on 15/01/2021.
//

import Foundation
final class UseCaseBuilder {
    let serviceBuilder: ServicesBuilder
    init(serviceBuilder: ServicesBuilder) {
        self.serviceBuilder = serviceBuilder
    }
    
    lazy var getIconUseCase: GetIconUseCaseProtocol = {
        let repository = DefaultPosterImagesRepository(dataRemoteService: serviceBuilder.imageDataTransferService, local: serviceBuilder.imageDataStorage)
        return GetIconUseCase(repository: repository)
    }()
    
    lazy var addWeatherUseCase: AddWeatherUseCaseProtocol = {
        let repository = DefaultCurrentWeatherRepository(dataRemoteService: serviceBuilder.apiDataTransferService,
                                                         dataLocalService: serviceBuilder.currentWeatherDataStorage)
        return AddWeatherUseCase(repository: repository)
    }()
    
    lazy var currentWeathersUseCase: CurrentWeathersUseCaseProtocol = {
        let repository = DefaultCurrentWeatherRepository(dataRemoteService: serviceBuilder.apiDataTransferService,
                                                         dataLocalService: serviceBuilder.currentWeatherDataStorage)
        return CurrentWeathersUseCase(repository: repository)
    }()
    
    lazy var forecastUseCase: ForecastUseCaseProtocol = {
        let repository = DefaultCurrentForecastWeather(dataRemoteService: serviceBuilder.apiDataTransferService,
                                                       dataLocalService: serviceBuilder.forecastDataStorage)
        return ForecastUseCase(repository: repository)
    }()
    
}
