//
//  WeatherDTO.swift
//  OpenWeather
//
//  Created by Youssef Marouane on 07/01/2021.
//  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation
struct WeatherDTO: Codable {
    let id : Int
    let main : String
    let description : String
    let icon : String
    enum CodingKeys: String, CodingKey {
        case id
        case main
        case description
        case icon
    }
}

extension WeatherDTO {
    func toDomaine() -> WeatherItem {
        WeatherItem(id: id,
                main: main,
                description: description,
                icon: icon)
    }
}
