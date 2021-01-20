//
//  SearchWeatherDataUseCaseTest.swift
//  OpenWeatherTests
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane. All rights reserved.  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import XCTest
@testable import OpenWeatherCore
class ForeCastWeatherDataUseCaseTest: XCTestCase {
    
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
    
    static let foreCastItems: [ForecastItem] = [ForecastItem.base(pressure: 10.0, humidity: 20.0, speed: 30.0),ForecastItem.base(pressure: 11.0, humidity: 22.0, speed: 33.0),ForecastItem.base(pressure: 12.0, humidity: 23.0, speed: 35.0)]
    
    static let cachedForeCastItems: [ForecastItem] = [ForecastItem.base(pressure: 111.0, humidity: 112.0, speed: 130.0),ForecastItem.base(pressure: 111.0, humidity: 122.0, speed: 133.0)]
    
    enum weatherRepositoryTestError: Error {
        case failedFetching
        case NetworkError
    }
    
    struct RepositoryMock: ForecastWeatherLoader {
        
        var remoteResponse: Result<[ForecastItem], Error>
        var cachResponse: Result<[ForecastItem], Error>
        func fetch(query: ForecastWeatherQuery,
                   cached: @escaping (fetchResult) -> Void,
                   completion: @escaping (fetchResult) -> Void) {
            cached(cachResponse)
            completion(remoteResponse)
        }
    }
    
    func test_success_fetchWeatherData() {
        let expectation = self.expectation(description: "search wetaher items")
        expectation.expectedFulfillmentCount = 2
        var expectedCache = [ForecastItem]()
        var expectedRemote = [ForecastItem]()
        let repository = RepositoryMock(remoteResponse: .success(ForeCastWeatherDataUseCaseTest.foreCastItems),
                                        cachResponse: .success(ForeCastWeatherDataUseCaseTest.cachedForeCastItems))
        let useCase = ForecastUseCase(repository: repository)
        
        useCase.execute(query: "paris", count: 5) { result in
            expectedCache = (try? result.get()) ?? []
            expectation.fulfill()
        } completion: { result in
            expectedRemote = (try? result.get()) ?? []
            expectation.fulfill()
        }
        
        XCTAssertEqual(expectedCache.count, 2)
        XCTAssertEqual(expectedRemote.count, 3)
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_failed_Network_fetchWeatherData() {
        let expectation = self.expectation(description: "search wetaher items")
        expectation.expectedFulfillmentCount = 2
        var expectedCache = [ForecastItem]()
        var expectedRemote = [ForecastItem]()
        
        let repository = RepositoryMock(remoteResponse: .failure(weatherRepositoryTestError.NetworkError), cachResponse: .success(ForeCastWeatherDataUseCaseTest.cachedForeCastItems))
        let useCase = ForecastUseCase(repository: repository)
        
        useCase.execute(query: "paris", count: 5) { result in
            expectedCache = (try? result.get()) ?? []
            expectation.fulfill()
        } completion: { result in
            expectedRemote = (try? result.get()) ?? []
            expectation.fulfill()
        }
        
        XCTAssertEqual(expectedCache.count, 2)
        XCTAssertTrue(expectedRemote.isEmpty)
        XCTAssertEqual(expectedCache[0].pressure, 111.0)
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_failed_cache_fetchWeatherData() {
        let expectation = self.expectation(description: "search wetaher items")
        expectation.expectedFulfillmentCount = 2
        var expectedCache = [ForecastItem]()
        var expectedRemote = [ForecastItem]()
        
        let repository = RepositoryMock(remoteResponse: .success(ForeCastWeatherDataUseCaseTest.cachedForeCastItems), cachResponse: .failure(weatherRepositoryTestError.failedFetching))
        let useCase = ForecastUseCase(repository: repository)
        
        useCase.execute(query: "paris", count: 5) { result in
            expectedCache = (try? result.get()) ?? []
            expectation.fulfill()
        } completion: { result in
            expectedRemote = (try? result.get()) ?? []
            expectation.fulfill()
        }
        
        XCTAssertEqual(expectedRemote.count, 2)
        XCTAssertTrue(expectedCache.isEmpty)
        wait(for: [expectation], timeout: 0.1)
    }
}
