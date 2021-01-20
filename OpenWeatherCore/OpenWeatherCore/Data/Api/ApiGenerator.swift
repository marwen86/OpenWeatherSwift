//
//  MovieApi.swift
//  CodawayGen
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane.
//

import Foundation


struct ApiGenerator {
    
    static func getWeatherForecast(with requestDTO: ForecastWeatherRequestDTO) -> Endpoint {
        return Endpoint(path: "data/2.5/forecast/daily",
                        method: .get,
                        queryParameters: ["q": requestDTO.query,
                                          "cnt": requestDTO.count])
        
    }
    
    static func getCurrentWeather(with requestDTO: WeatherRequestDTO) -> Endpoint {
        return Endpoint(path: "data/2.5/weather",
                        method: .get,
                        queryParameters: ["q": requestDTO.query])
        
    }

    static func getWeatherIcon(icon: String) -> Endpoint {
        return Endpoint(path: "img/wn/\(icon)@2x.png",
                        method: .get)
    }
}
