//
//  AddWeatherUseCaseTest.swift
//  OpenWeatherCoreTests
//
//  Created by Youssef Marouane on 15/01/2021.
//

import XCTest
@testable import OpenWeatherCore

class AddWeatherUseCaseTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    static let item: CurrentWeatherItem = CurrentWeatherItem.base()

    
    enum weatherRepositoryTestError: Error {
        case failedFetching
        case NetworkError
    }
    
    struct RepositoryMock: CurrentWeatherRepository {
        var response: Result<CurrentWeatherItem?, Error>
        func fetchAll(completion: @escaping (fetchAllResult) -> Void) {
           
        }
        
        func fetch(query: CurrentWeatherQuery,
                   completion: @escaping (fetchResult) -> Void) {
            completion(response)
        }
    }
    
    func test_success_add_WeatherData() {
        let expectation = self.expectation(description: "search wetaher items")
        expectation.expectedFulfillmentCount = 2
        var expectedData: CurrentWeatherItem?
        let repository = RepositoryMock(response: .success(AddWeatherUseCaseTest.item))
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
        expectation.expectedFulfillmentCount = 2
        var expectedData: CurrentWeatherItem?
        let repository = RepositoryMock(response: .failure(weatherRepositoryTestError.failedFetching))
        let useCase = AddWeatherUseCase(repository: repository)
        
        useCase.execute(city: "paris") { result in
            expectedData = (try? result.get())
            expectation.fulfill()
        }
    
        XCTAssertTrue(expectedData == nil)
        wait(for: [expectation], timeout: 0.1)
    }
    

}
