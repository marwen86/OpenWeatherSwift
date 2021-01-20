//
//  WeatherItem.swift
//  OpenWeather
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane.
//

import Foundation

public struct ForecastItem {
    public init(pressure: Double, humidity: Double, speed: Double, deg: Int, clouds: Int, weather: [WeatherItem], temp: Temp?) {
        self.pressure = pressure
        self.humidity = humidity
        self.speed = speed
        self.deg = deg
        self.clouds = clouds
        self.weather = weather
        self.temp = temp
    }
    
    public let pressure : Double
    public let humidity : Double
    public let speed : Double
    public let deg : Int
    public let clouds : Int
    public let weather: [WeatherItem]
    public let temp: Temp?
}

public struct Temp {
    public init(day: Double, min: Double, max: Double, night: Double, eve: Double, morn: Double) {
        self.day = day
        self.min = min
        self.max = max
        self.night = night
        self.eve = eve
        self.morn = morn
    }
    
    public let day : Double
    public let min : Double
    public let max : Double
    public let night : Double
    public let eve : Double
    public let morn : Double
}


