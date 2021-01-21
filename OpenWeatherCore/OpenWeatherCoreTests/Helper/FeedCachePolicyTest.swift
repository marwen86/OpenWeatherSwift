//
//  FeedCachePolicyTest.swift
//  OpenWeatherCoreTests
//
//  Created by Youssef Marouane on 21/01/2021.
//

import XCTest
@testable import OpenWeatherCore

class FeedCachePolicyTest: XCTestCase {
    
    func test_success_validate_cahePolicy() {
        // Given
        let calendar = Calendar(identifier: .gregorian)
        guard let timestamp = calendar.date(byAdding: .hour, value: -1, to: Date()) else { return }
        let currentDate = Date()
        
        // When
        let valide = FeedCachePolicy.validate(timestamp, against: currentDate)

        // Then
        XCTAssertTrue(valide)
    }
    
    func test_failure_validate_cahePolicy() {
        // Given
        let calendar = Calendar(identifier: .gregorian)
        guard let timestamp = calendar.date(byAdding: .day, value: -1, to: Date()) else { return }
        let currentDate = Date()
        
        // When
        let valide = FeedCachePolicy.validate(timestamp, against: currentDate)
        
        // Then
        XCTAssertFalse(valide)
    }

}
