//
//  UtilitiesTest.swift
//  OpenWeatherTests
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane.
//

import XCTest
@testable import OpenWeather

class UtilitiesTest: XCTestCase {
    func test_conversion_kelvin_to_deg() {
        let kelvin = 256.0
        XCTAssertEqual(kelvin.kelvinToDeg, kelvin - 273.15)
    }

}
