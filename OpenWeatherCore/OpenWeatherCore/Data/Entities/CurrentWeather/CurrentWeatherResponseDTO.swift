//
//  WeatherItemResponseDTO.swift
//  OpenWeather
//
//  Created by Youssef Marouane.
//  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation
struct CurrentWeatherResponseDTO: Decodable {
    let weather: [WeatherDTO]
    let visibility: Int
    let wind: WindDTO?
    let clouds: CloudsDTO?
    let main: MainDTO?
    
    enum CodingKeys: String, CodingKey {
        case weather
        case visibility
        case wind
        case clouds
        case main
    }
    
    static let empty: CurrentWeatherResponseDTO = CurrentWeatherResponseDTO(weather: [],
                                                                            visibility: 0,
                                                                            wind: nil,
                                                                            clouds: nil,
                                                                            main: nil)
}

struct MainDTO: Decodable {
    let temp : Double
    let feelsLike : Double
    let tempMin : Double
    let tempMax : Double
    let pressure : Int
    let humidity : Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
}

struct WindDTO: Decodable {
    let speed : Double
    let deg : Int
    
    enum CodingKeys: String, CodingKey {
        case speed
        case deg
    }
}

struct CloudsDTO: Decodable {
    let cloud: Int
    enum CodingKeys: String, CodingKey {
        case cloud = "all"
    }
}

extension CurrentWeatherResponseDTO {
    func toDomaine() -> CurrentWeatherItem {
       return CurrentWeatherItem(weather: self.weather.map { $0.toDomaine() },
                           visibility: visibility,
                           clouds: clouds?.cloud ?? 0,
                           temp: main?.temp ?? 0,
                           feelsLike: main?.feelsLike ?? 0,
                           tempMin: main?.tempMin ?? 0,
                           tempMax: main?.tempMax ?? 0,
                           pressure: main?.pressure ?? 0,
                           humidity: main?.humidity ?? 0,
                           speed: wind?.speed ?? 0,
                           deg: wind?.deg ?? 0)
    }
}
