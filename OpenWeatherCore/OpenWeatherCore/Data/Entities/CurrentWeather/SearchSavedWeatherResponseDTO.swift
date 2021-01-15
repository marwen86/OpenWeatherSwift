//
//  SearchSavedWeatherResponseDTO.swift
//  OpenWeather
//
//  Created by Youssef Marouane on 13/01/2021.
//  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation
struct SearchSavedWeatherResponseDTO {
    let weather: CurrentWeatherResponseDTO?
    let city: String?
}

extension SearchSavedWeatherResponseDTO {
    func toDomaine() -> SearchSavedWeatherItem {
        SearchSavedWeatherItem(weather: weather?.toDomaine(),
                               city: city)
    }
}
