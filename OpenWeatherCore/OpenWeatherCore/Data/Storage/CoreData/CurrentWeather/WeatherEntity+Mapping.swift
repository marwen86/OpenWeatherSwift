//
//  WeatherEntity+Mapping.swift
//  OpenWeather
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation
import CoreData

extension WeatherEntity {
    func toDTO() -> WeatherDTO {
        return .init(id: Int(id),
                     main: main ?? "",
                     description: descript ?? "",
                     icon: icon ?? "")
    }
}

extension WeatherDTO {
    func toEntity(in context: NSManagedObjectContext) -> WeatherEntity {
        let entity: WeatherEntity = .init(context: context)
        entity.id = Int32(Int16(id))
        entity.descript = description
        entity.icon = icon
        entity.main = main
        return entity
    }
    
}
