//
//  WeatherItem.swift
//  OpenWeather
//
//  Created by Youssef Marouane on 07/01/2021.
//  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation
public struct CurrentWeatherItem {
    public init(weather: [WeatherItem], visibility: Int, clouds: Int, temp: Double, feelsLike: Double, tempMin: Double, tempMax: Double, pressure: Int, humidity: Int, speed: Double, deg: Int) {
        self.weather = weather
        self.visibility = visibility
        self.clouds = clouds
        self.temp = temp
        self.feelsLike = feelsLike
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.pressure = pressure
        self.humidity = humidity
        self.speed = speed
        self.deg = deg
    }
    
    public let weather: [WeatherItem]
    public let visibility: Int
    public let clouds: Int
    public let temp : Double
    public let feelsLike : Double
    public let tempMin : Double
    public let tempMax : Double
    public let pressure : Int
    public let humidity : Int
    public let speed : Double
    public let deg : Int
}
