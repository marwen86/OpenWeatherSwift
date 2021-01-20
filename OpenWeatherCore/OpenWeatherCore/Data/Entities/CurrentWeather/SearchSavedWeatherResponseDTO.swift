//
//  SearchSavedWeatherResponseDTO.swift
//  OpenWeather
//
//  Created by Youssef Marouane.
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
