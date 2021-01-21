//
//  SearchWeatherDataUseCaseTest.swift
//  OpenWeatherTests
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane.
//

import XCTest
@testable import OpenWeatherCore
class ForeCastWeatherDataUseCaseTest: XCTestCase {
    
    static let foreCastItems: [ForecastItem] = [ForecastItem.base(pressure: 10.0, humidity: 20.0, speed: 30.0),ForecastItem.base(pressure: 11.0, humidity: 22.0, speed: 33.0),ForecastItem.base(pressure: 12.0, humidity: 23.0, speed: 35.0)]
    
    static let cachedForeCastItems: [ForecastItem] = [ForecastItem.base(pressure: 111.0, humidity: 112.0, speed: 130.0),ForecastItem.base(pressure: 111.0, humidity: 122.0, speed: 133.0)]
    
    enum weatherRepositoryTestError: Error {
        case failedFetching
        case NetworkError
    }
    

    
    func test_success_fetchWeatherData() {
        // Given
        let expectation = self.expectation(description: "search wetaher items")
        expectation.expectedFulfillmentCount = 2
        var expectedCache = [ForecastItem]()
        var expectedRemote = [ForecastItem]()
        let repository = ForecastLoaderMock(remoteResponse: .success(ForeCastWeatherDataUseCaseTest.foreCastItems),
                                        cachResponse: .success(ForeCastWeatherDataUseCaseTest.cachedForeCastItems))
        let useCase = ForecastUseCase(repository: repository)
        
        // When
        useCase.execute(query: "paris", count: 5) { result in
            expectedCache = (try? result.get()) ?? []
            expectation.fulfill()
        } completion: { result in
            expectedRemote = (try? result.get()) ?? []
            expectation.fulfill()
        }
        
        // Then
        XCTAssertEqual(expectedCache.count, 2)
        XCTAssertEqual(expectedRemote.count, 3)
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_failed_Network_fetchWeatherData() {
        // Given
        let expectation = self.expectation(description: "search wetaher items")
        expectation.expectedFulfillmentCount = 2
        var expectedCache = [ForecastItem]()
        var expectedRemote = [ForecastItem]()
        
        let repository = ForecastLoaderMock(remoteResponse: .failure(weatherRepositoryTestError.NetworkError), cachResponse: .success(ForeCastWeatherDataUseCaseTest.cachedForeCastItems))
        let useCase = ForecastUseCase(repository: repository)
        
        // When
        useCase.execute(query: "paris", count: 5) { result in
            expectedCache = (try? result.get()) ?? []
            expectation.fulfill()
        } completion: { result in
            expectedRemote = (try? result.get()) ?? []
            expectation.fulfill()
        }
        
        // Then
        XCTAssertEqual(expectedCache.count, 2)
        XCTAssertTrue(expectedRemote.isEmpty)
        XCTAssertEqual(expectedCache[0].pressure, 111.0)
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_failed_cache_fetchWeatherData() {
        // Given
        let expectation = self.expectation(description: "search wetaher items")
        expectation.expectedFulfillmentCount = 2
        var expectedCache = [ForecastItem]()
        var expectedRemote = [ForecastItem]()
        
        let repository = ForecastLoaderMock(remoteResponse: .success(ForeCastWeatherDataUseCaseTest.cachedForeCastItems), cachResponse: .failure(weatherRepositoryTestError.failedFetching))
        let useCase = ForecastUseCase(repository: repository)
        
        // When
        useCase.execute(query: "paris", count: 5) { result in
            expectedCache = (try? result.get()) ?? []
            expectation.fulfill()
        } completion: { result in
            expectedRemote = (try? result.get()) ?? []
            expectation.fulfill()
        }
        
        // Then
        XCTAssertEqual(expectedRemote.count, 2)
        XCTAssertTrue(expectedCache.isEmpty)
        wait(for: [expectation], timeout: 0.1)
    }
}
