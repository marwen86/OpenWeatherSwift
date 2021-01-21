//
//  Date+UtilsTest.swift
//  OpenWeatherTests
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane.
//

import XCTest
@testable import OpenWeather
class Date_UtilsTest: XCTestCase {

    func test_dayInWeek() {
        // Given
        let dateStr = "Wednesday, Sep 12, 2018"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        
        // When
        let date = dateFormatter.date(from:dateStr)!
        
        // Then
        XCTAssertEqual(date.dayInWeek, "Wednesday")
    }
    
    func test_datebyAddingDay() {
        // Given
        let currentDateStr = "Sep 12, 2018"
        let expectedDateStr = "Sep 14, 2018"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
       
        // When
        let currentDate = dateFormatter.date(from:currentDateStr)!
        let expectedDate = dateFormatter.date(from:expectedDateStr)!
        
        // Then
        XCTAssertEqual(currentDate.DatebyAddingDay(day: 2), expectedDate)
    }

}
