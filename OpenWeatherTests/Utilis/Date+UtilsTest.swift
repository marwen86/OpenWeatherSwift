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

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_dayInWeek() {
        let dateStr = "Wednesday, Sep 12, 2018"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        let date = dateFormatter.date(from:dateStr)!
        
        XCTAssertEqual(date.dayInWeek, "Wednesday")
    }
    
    func test_datebyAddingDay() {
        let currentDateStr = "Sep 12, 2018"
        let expectedDateStr = "Sep 14, 2018"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let currentDate = dateFormatter.date(from:currentDateStr)!
        let expectedDate = dateFormatter.date(from:expectedDateStr)!
        
        XCTAssertEqual(currentDate.DatebyAddingDay(day: 2), expectedDate)
    }

}
