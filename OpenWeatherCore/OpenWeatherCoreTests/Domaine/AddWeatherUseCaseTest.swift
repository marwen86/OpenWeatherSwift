//
//  AddWeatherUseCaseTest.swift
//  OpenWeatherCoreTests
//
//  Created by Youssef Marouane.
//

import XCTest
@testable import OpenWeatherCore

class AddWeatherUseCaseTest: XCTestCase {

    static let item: CurrentWeatherItem = CurrentWeatherItem.base()

    
    enum weatherRepositoryTestError: Error {
        case failedFetching
        case NetworkError
    }
    
    func test_success_add_WeatherData() {
        let expectation = self.expectation(description: "search wetaher items")
        expectation.expectedFulfillmentCount = 1
        var expectedData: CurrentWeatherItem?
        let repository = CurrentWeatherLoaderMock(fetchAllresponse: nil, fetchResponse: .success(AddWeatherUseCaseTest.item))
        let useCase = AddWeatherUseCase(repository: repository)
        
        useCase.execute(city: "paris") { result in
            expectedData = (try? result.get())
            expectation.fulfill()
        }
        
        XCTAssertFalse(expectedData == nil)
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_failed_add_WeatherData() {
        let expectation = self.expectation(description: "search wetaher items")
        expectation.expectedFulfillmentCount = 1
        var expectedData: CurrentWeatherItem?
        let repository = CurrentWeatherLoaderMock(fetchAllresponse: nil, fetchResponse: .failure(weatherRepositoryTestError.failedFetching))
        let useCase = AddWeatherUseCase(repository: repository)
        
        useCase.execute(city: "paris") { result in
            expectedData = (try? result.get())
            expectation.fulfill()
        }
    
        XCTAssertTrue(expectedData == nil)
        wait(for: [expectation], timeout: 0.1)
    }
    

}
