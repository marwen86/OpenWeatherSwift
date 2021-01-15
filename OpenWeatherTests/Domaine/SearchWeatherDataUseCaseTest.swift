//
//  SearchWeatherDataUseCaseTest.swift
//  OpenWeatherTests
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane. All rights reserved.  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import XCTest

class SearchWeatherDataUseCaseTest: XCTestCase {

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
    
    static let weatherItems: [WeatherItem] = [WeatherItem.base(pressure: 10.0, humidity: 20.0, speed: 30.0),WeatherItem.base(pressure: 11.0, humidity: 22.0, speed: 33.0),WeatherItem.base(pressure: 12.0, humidity: 23.0, speed: 35.0)]
    
    static let cachedWeatherItems: [WeatherItem] = [WeatherItem.base(pressure: 111.0, humidity: 112.0, speed: 130.0),WeatherItem.base(pressure: 111.0, humidity: 122.0, speed: 133.0)]
    
    enum weatherRepositoryTestError: Error {
           case failedFetching
           case NetworkError
    }
    
    struct WeatherRepositoryMock: WeatherRepository {
        
        var remoteResponse: Result<[WeatherItem], Error>
        var cachResponse: Result<[WeatherItem], Error>
        func fetchWeatherList(count: Int,
                                    city: String,
                                    cached: @escaping SearchWeatherCompletion,
                                    completion: @escaping SearchWeatherCompletion) {
            cached(cachResponse)
            completion(remoteResponse)
        }
    }
    
    func test_success_fetchWeatherData() {
        let expectation = self.expectation(description: "search wetaher items")
         expectation.expectedFulfillmentCount = 2
        var expectedCache = [WeatherItem]()
        var expectedRemote = [WeatherItem]()
        let weatherRepository = WeatherRepositoryMock(remoteResponse: .success(SearchWeatherDataUseCaseTest.weatherItems), cachResponse: .success(SearchWeatherDataUseCaseTest.cachedWeatherItems))
        let weatherUseCase = SearchWeatherDataUseCase(mediaRepository: weatherRepository)
        weatherUseCase.execute(count: 5, city: "paris", cached: { result in
            expectedCache = (try? result.get()) ?? []
             expectation.fulfill()
        }) { result in
            expectedRemote = (try? result.get()) ?? []
             expectation.fulfill()
        }
        
        
        XCTAssertEqual(expectedCache.count, 2)
        XCTAssertEqual(expectedRemote.count, 3)
        XCTAssertEqual(expectedCache[0].pressure, 111.0)
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_failed_Network_fetchWeatherData() {
        let expectation = self.expectation(description: "search wetaher items")
         expectation.expectedFulfillmentCount = 2
        var expectedCache = [WeatherItem]()
        var expectedRemote = [WeatherItem]()
        let weatherRepository = WeatherRepositoryMock(remoteResponse: .failure(weatherRepositoryTestError.NetworkError), cachResponse: .success(SearchWeatherDataUseCaseTest.cachedWeatherItems))
        let weatherUseCase = SearchWeatherDataUseCase(mediaRepository: weatherRepository)
        weatherUseCase.execute(count: 5, city: "paris", cached: { result in
            expectedCache = (try? result.get()) ?? []
             expectation.fulfill()
        }) { result in
            expectedRemote = (try? result.get()) ?? []
             expectation.fulfill()
        }
        
        XCTAssertEqual(expectedCache.count, 2)
        XCTAssertTrue(expectedRemote.isEmpty)
        XCTAssertEqual(expectedCache[0].pressure, 111.0)
        wait(for: [expectation], timeout: 0.1)
    }
}
