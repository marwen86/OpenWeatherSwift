//
//  WeatherItemsResponseDTO.swift
//  OpenWeather
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane. All rights reserved.  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation

struct WeatherForecastItemsResponseDTO: Codable {
    let list: [WeatherForeCastItemDTO]
    enum CodingKeys: String, CodingKey {
        case list
    }
}


struct WeatherForeCastItemDTO: Codable {
    let pressure : Double
    let humidity : Double
    let speed : Double
    let deg : Int
    let clouds : Int
    let weather: [WeatherDTO]
    let temp: TempDTO?
    enum CodingKeys: String, CodingKey {
        case pressure
        case humidity
        case speed
        case deg
        case clouds
        case weather
        case temp
    }
}

struct TempDTO: Codable {
    let day : Double
    let min : Double
    let max : Double
    let night : Double
    let eve : Double
    let morn : Double
    enum CodingKeys: String, CodingKey {
        case day
        case min
        case max
        case night
        case eve
        case morn
    }
}


extension TempDTO {
    func toDomaine() -> Temp { Temp(day: day,
                                    min: min,
                                    max: max,
                                    night: night,
                                    eve: eve,
                                    morn: morn) }
}

extension WeatherForeCastItemDTO {
    func toDomaine() -> ForecastItem {
        ForecastItem.init(pressure: pressure,
                          humidity: humidity,
                          speed: speed,
                          deg: deg,
                          clouds: clouds,
                          weather: self.weather.map { $0.toDomaine() },
                          temp: temp?.toDomaine())
    }
}
