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
        // Given
        let expectation = self.expectation(description: "search wetaher items")
        expectation.expectedFulfillmentCount = 1
        var expectedData: CurrentWeatherItem?
        let repository = CurrentWeatherLoaderMock(fetchAllresponse: nil, fetchResponse: .success(AddWeatherUseCaseTest.item))
        let useCase = AddWeatherUseCase(repository: repository)
        
        // When
        useCase.execute(city: "paris") { result in
            expectedData = (try? result.get())
            expectation.fulfill()
        }
        
        // Then
        XCTAssertFalse(expectedData == nil)
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_failed_add_WeatherData() {
        // Given
        let expectation = self.expectation(description: "search wetaher items")
        expectation.expectedFulfillmentCount = 1
        var expectedData: CurrentWeatherItem?
        let repository = CurrentWeatherLoaderMock(fetchAllresponse: nil, fetchResponse: .failure(weatherRepositoryTestError.failedFetching))
        let useCase = AddWeatherUseCase(repository: repository)
        
        // When
        useCase.execute(city: "paris") { result in
            expectedData = (try? result.get())
            expectation.fulfill()
        }
        
        // Then
        XCTAssertTrue(expectedData == nil)
        wait(for: [expectation], timeout: 0.1)
    }
    

}
