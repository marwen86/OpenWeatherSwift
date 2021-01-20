//
//  Date+Utils.swift
//  OpenWeather
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane.
//

import Foundation
public extension Date {
    var dayInWeek: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
    func DatebyAddingDay(day: Int) -> Date {
        var dayComponent    = DateComponents()
        dayComponent.day    = day
        let theCalendar     = Calendar.current
        return theCalendar.date(byAdding: dayComponent, to: self) ?? Date()
    }
}
