//
//  WeatherItemResponseDTO.swift
//  OpenWeather
//
//  Created by Youssef Marouane.
//  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation
struct CurrentWeatherResponseDTO: Codable {
    let weather: [WeatherDTO]
    let visibility: Int
    let wind: WindDTO
    let clouds: Clouds
    let main: MainDTO
    
    enum CodingKeys: String, CodingKey {
        case weather
        case visibility
        case wind
        case clouds
        case main
    }
    
    struct Clouds: Codable {
        let all: Int
        enum CodingKeys: String, CodingKey {
            case all
        }
    }
    struct MainDTO: Codable {
        let temp : Double
        let feels_like : Double
        let temp_min : Double
        let temp_max : Double
        let pressure : Int
        let humidity : Int
        
        enum CodingKeys: String, CodingKey {
            case temp
            case feels_like
            case temp_min
            case temp_max
            case pressure
            case humidity
        }
    }
    
    struct WindDTO: Codable {
        let speed : Double
        let deg : Int
        
        enum CodingKeys: String, CodingKey {
            case speed
            case deg
        }
    }
}

extension CurrentWeatherResponseDTO {
    func toDomaine(city: String) -> CurrentWeatherItem {
        CurrentWeatherItem(weather: self.weather.map { $0.toDomaine() },
                           visibility: visibility,
                           clouds: clouds.all,
                           city: city,
                           temp: main.temp,
                           feels_like: main.feels_like,
                           temp_min: main.temp_min,
                           temp_max: main.temp_max,
                           pressure: main.pressure,
                           humidity: main.humidity,
                           speed: wind.speed,
                           deg: wind.deg)
    }
}
