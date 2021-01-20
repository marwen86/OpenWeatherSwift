//
//  OpenWeather.swift
//  OpenWeatherCore
//
//  Created by Youssef Marouane.
//

import Foundation
public class OpenWeather {
    
    public struct UseCases {
        public let getIconUseCase: GetIconUseCaseProtocol
        public let addWeatherUseCase: AddWeatherUseCaseProtocol
        public let savedcurrentWeathersUseCase: SavedWeathersUseCaseProtocol
        public let forecastUseCase: ForecastUseCaseProtocol
        public let fetchWeather: FetchWeatherUseCaseProtocol
    }
    
    public class func start(apiBaseUrl: String,
                            iconBaseUrl: String,
                            apiKey: String) -> UseCases {
        let apiConfiguration = ApiConfiguration(apiBaseURL: apiBaseUrl, iconBaseURL: iconBaseUrl, apiKey: apiKey)
        let serviceBuilder = ServicesBuilder(apiConfiguration: apiConfiguration)
        let useCaseBuilder = UseCaseBuilder(serviceBuilder: serviceBuilder)
        return UseCases(getIconUseCase: useCaseBuilder.getIconUseCase,
                        addWeatherUseCase: useCaseBuilder.addWeatherUseCase,
                        savedcurrentWeathersUseCase: useCaseBuilder.savedWeathersUseCase,
                        forecastUseCase: useCaseBuilder.forecastUseCase,
                        fetchWeather: useCaseBuilder.currentWeatherUseCase)
    }
}
