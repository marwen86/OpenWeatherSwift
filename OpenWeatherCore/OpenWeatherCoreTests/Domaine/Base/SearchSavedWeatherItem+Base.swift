//
//  SearchSavedWeatherItem+Base.swift
//  OpenWeatherCoreTests
//
//  Created by Youssef Marouane.
//

import Foundation
import OpenWeatherCore

extension SearchSavedWeatherItem : Equatable {
    public static func == (lhs: SearchSavedWeatherItem, rhs: SearchSavedWeatherItem) -> Bool {
        return true
    }
    
    
    static func base(weather: CurrentWeatherItem = CurrentWeatherItem.base(),
                     city: String = "Paris") -> SearchSavedWeatherItem {
        
     return SearchSavedWeatherItem(weather: weather, city: city)
    }
}
