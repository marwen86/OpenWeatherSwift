//
//  CurrentWeatherUseCaseTest.swift
//  OpenWeatherCoreTests
//
//  Created by Youssef Marouane.
//

import XCTest
@testable import OpenWeatherCore

class CurrentWeatherUseCaseTest: XCTestCase {
    
    static let items: [SearchSavedWeatherItem] = [SearchSavedWeatherItem.base(weather: CurrentWeatherItem.base(), city: "Paris"), SearchSavedWeatherItem.base(weather: CurrentWeatherItem.base(), city: "Lille")]

    
    enum weatherRepositoryTestError: Error {
        case failedFetching
        case NetworkError
    }
        
    func test_success_fetchWeatherData() {
        let expectation = self.expectation(description: "search wetaher items1")
        expectation.expectedFulfillmentCount = 1
        var expectedData = [SearchSavedWeatherItem]()
        let repository = CurrentWeatherLoaderMock(fetchAllresponse: .success(CurrentWeatherUseCaseTest.items), fetchResponse: nil)
        let useCase = SavedWeathersUseCase(repository: repository)
        
        useCase.execute { result in
            expectedData = (try? result.get()) ?? []
            expectation.fulfill()
        }
        
        XCTAssertEqual(expectedData.count, 2)
        XCTAssertEqual( expectedData.map { $0.city }, ["Paris", "Lille"])
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_failed_fetchWeatherData() {
        let expectation = self.expectation(description: "search wetaher items2")
        expectation.expectedFulfillmentCount = 1
        var expectedData = [SearchSavedWeatherItem]()
        let repository = CurrentWeatherLoaderMock(fetchAllresponse: .failure(weatherRepositoryTestError.failedFetching), fetchResponse: nil)
        let useCase = SavedWeathersUseCase(repository: repository)
        
        useCase.execute { result in
            expectedData = (try? result.get()) ?? []
            expectation.fulfill()
        }
    
        XCTAssertTrue(expectedData.isEmpty)
        wait(for: [expectation], timeout: 0.1)
    }
}
