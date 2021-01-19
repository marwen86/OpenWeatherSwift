//
//  CurrentWeatherUseCaseTest.swift
//  OpenWeatherCoreTests
//
//  Created by Youssef Marouane on 15/01/2021.
//

import XCTest
@testable import OpenWeatherCore

class CurrentWeatherUseCaseTest: XCTestCase {

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
    
    static let items: [SearchSavedWeatherItem] = [SearchSavedWeatherItem.base(weather: CurrentWeatherItem.base(), city: "Paris"), SearchSavedWeatherItem.base(weather: CurrentWeatherItem.base(), city: "Lille")]

    
    enum weatherRepositoryTestError: Error {
        case failedFetching
        case NetworkError
    }
    
    struct RepositoryMock: CurrentWeatherRepository {
        var response: Result<[SearchSavedWeatherItem], Error>
        func fetchAll(completion: @escaping (fetchAllResult) -> Void) {
            completion(response)
        }
        
        func fetch(query: CurrentWeatherQuery,
                   completion: @escaping (fetchResult) -> Void) {
            
        }
    }
    
    func test_success_fetchWeatherData() {
        let expectation = self.expectation(description: "search wetaher items1")
        expectation.expectedFulfillmentCount = 2
        var expectedData = [SearchSavedWeatherItem]()
        let repository = RepositoryMock(response: .success(CurrentWeatherUseCaseTest.items))
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
        expectation.expectedFulfillmentCount = 2
        var expectedData = [SearchSavedWeatherItem]()
        let repository = RepositoryMock(response: .failure(weatherRepositoryTestError.failedFetching))
        let useCase = SavedWeathersUseCase(repository: repository)
        
        useCase.execute { result in
            expectedData = (try? result.get()) ?? []
            expectation.fulfill()
        }
    
        XCTAssertTrue(expectedData.isEmpty)
        wait(for: [expectation], timeout: 0.1)
    }
}
