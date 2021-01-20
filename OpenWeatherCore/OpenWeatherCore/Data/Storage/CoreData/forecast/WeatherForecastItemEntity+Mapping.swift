//
//  WeatherItemEntity+Mapping.swift
//  OpenWeather
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane. All rights reserved.  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation
import CoreData


extension WeatherForecastResponseEntity {
    func toDTO() -> WeatherForecastItemsResponseDTO {
        return .init(list: list?.allObjects.map { ($0 as! WeatherForecastItemEntity).toDTO() } ?? [])
    }
}

extension WeatherForecastItemEntity {
    func toDTO() -> WeatherForeCastItemDTO {
        return .init(pressure: pressure,
                     humidity: humidity,
                     speed: speed,
                     deg: Int(deg),
                     clouds: Int(clouds),
                     weather: weather?.allObjects.map { ($0 as! WeatherEntity).toDTO() } ?? [],
                     temp: temp?.toDTO())
    }
}

extension TempEntity {
    func toDTO() -> TempDTO {
        .init(day: day,
              min: day,
              max: max,
              night: night,
              eve: eve,
              morn: morn)
    }
}

extension WeatherForecastItemsResponseDTO {
    func toEntity(in context: NSManagedObjectContext) -> WeatherForecastResponseEntity {
        let entity: WeatherForecastResponseEntity = .init(context: context)
        list.forEach {
            entity.addToList($0.toEntity(in: context))
        }
        entity.timestamp = Date()
        return entity
    }
}

extension ForecastWeatherRequestDTO {
    func toEntity(in context: NSManagedObjectContext) -> WeatherForecastRequestEntity {
        let entity: WeatherForecastRequestEntity = .init(context: context)
        entity.query = query
        entity.count = Int32(count)
        return entity
    }
}

extension WeatherForeCastItemDTO {
    func toEntity(in context: NSManagedObjectContext) -> WeatherForecastItemEntity {
        let entity: WeatherForecastItemEntity = .init(context: context)
        entity.pressure = pressure
        entity.humidity = humidity
        entity.speed = speed
        entity.deg = Int32(deg)
        entity.clouds = Int32(clouds)
        weather.forEach {
            entity.addToWeather($0.toEntity(in: context))
        }
        entity.temp = temp?.toEntity(in: context)
        return entity
    }
}

extension TempDTO {
    func toEntity(in context: NSManagedObjectContext) -> TempEntity {
        let entity: TempEntity = .init(context: context)
        entity.day = day
        entity.eve = eve
        entity.max = max
        entity.min = min
        entity.morn = morn
        entity.night = night
        return entity
    }
}

