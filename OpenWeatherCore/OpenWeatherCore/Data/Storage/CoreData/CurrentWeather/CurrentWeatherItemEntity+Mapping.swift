//
//  CurrentWeatherItemEntity+Mapping.swift
//  OpenWeather
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation
import CoreData

extension CurrentWeatherEntity {
    func toDTO() -> CurrentWeatherResponseDTO {
        return .init(weather: weather?.allObjects.map { ($0 as! WeatherEntity).toDTO() } ?? [],
                     visibility: Int(visibility),
                     wind: wind?.toDTO(),
                     clouds: clouds?.toDTO(),
                     main: main?.toDTO())
    }
    
}

extension MainEntity {
    func toDTO() -> MainDTO {
        return MainDTO(temp: temp,
                       feelsLike: feelsLike,
                       tempMin: tempMin,
                       tempMax: tempMax,
                       pressure: Int(pressure),
                       humidity: Int(humidity))
    }
}

extension CloudsEntity {
    func toDTO() -> CloudsDTO {
        return CloudsDTO(cloud: Int(cloud))
    }
}

extension WindEntity {
    func toDTO() -> WindDTO {
        return WindDTO(speed: speed, deg: Int(deg))
    }
}

extension WeatherRequestDTO {
    func toEntity(in context: NSManagedObjectContext) -> CurrentWeatherRequestEntity {
        let entity: CurrentWeatherRequestEntity = .init(context: context)
        entity.query = query
        return entity
    }
}

extension CurrentWeatherResponseDTO {
    func toEntity(in context: NSManagedObjectContext) -> CurrentWeatherEntity {
        let entity: CurrentWeatherEntity = .init(context: context)
        weather.forEach {
            entity.addToWeather($0.toEntity(in: context))
        }
        entity.clouds = clouds?.toEntity(in: context)
        entity.main =  main?.toEntity(in: context)
        entity.wind = wind?.toEntity(in: context)
        entity.timestamp = Date()
        return entity
    }
}

extension CloudsDTO {
    func toEntity(in context: NSManagedObjectContext) -> CloudsEntity {
        let entity: CloudsEntity = .init(context: context)
        entity.cloud = Int32(cloud)
        return entity
    }
}

extension WindDTO {
    func toEntity(in context: NSManagedObjectContext) -> WindEntity {
        let entity: WindEntity = .init(context: context)
        entity.deg = Int32(deg)
        entity.speed = speed
        return entity
    }
}

extension MainDTO {
    func toEntity(in context: NSManagedObjectContext) -> MainEntity {
        let entity: MainEntity = .init(context: context)
        entity.feelsLike = feelsLike
        entity.humidity = Int32(humidity)
        entity.pressure = Int32(pressure)
        entity.temp = temp
        entity.tempMax = tempMax
        entity.tempMin = tempMin
        return entity
    }
}
