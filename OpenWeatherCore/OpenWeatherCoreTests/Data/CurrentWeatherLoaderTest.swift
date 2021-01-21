//
//  CurrentWeatherLoaderTest.swift
//  OpenWeatherCoreTests
//
//  Created by Youssef Marouane on 21/01/2021.
//

import XCTest
@testable import OpenWeatherCore

class CurrentWeatherLoaderTest: XCTestCase {
    class RemoteDataServiceMock: RemoteDataServiceProtocol {
        var expectFailureReponse: Bool = false
        func fetchDailyForecast(endpoint: Requestable, completion: @escaping (RetrievalForcastResult) -> Void) {
            completion(.success(WeatherForecastItemsResponseDTO.empty))
        }
        
        func fetch(endpoint: Requestable, completion: @escaping (RetrievalWeatherResult) -> Void) {
            completion(expectFailureReponse ? .failure(RemoteDataError.noResponse):.success(CurrentWeatherResponseDTO.empty))
        }
        
        func fetchImage(endpoint: Requestable, completion: @escaping (RetrievalImageResult) -> Void) {
            
        }
    }
    
    class CurrentWeatherStorage: CurrentWeatherResponseStorage {
        var localRetriveCalled: (() -> Void)?
        var localInsertCalled: (() -> Void)?
        private var allCache: [SearchSavedWeatherResponseDTO] = []
        func insert(item: CurrentWeatherResponseDTO, requestDTO: WeatherRequestDTO, completion: @escaping (InsertionResult) -> Void) {
            localInsertCalled?()
            allCache.append(SearchSavedWeatherResponseDTO(weather: item, city: requestDTO.query))
            completion(.success(()))
        }
        
        func retrieve(with requestDTO: WeatherRequestDTO, completion: @escaping (RetrievalResult) -> Void) {
            localRetriveCalled?()
            completion(.success(allCache.filter { $0.city == requestDTO.query }.first?.weather))
        }
        
        func retrieveAll(completion: @escaping (RetrievalAllResult) -> Void) {
            completion(.success(allCache))
        }
    }
    
    func test_success_fetch_and_insert_CurrentWeather() {
        // Given
        let expectation = self.expectation(description: "loader fetch items")
        let remoteLoader = RemoteDataServiceMock()
        let localLoader = CurrentWeatherStorage()
        var expectedItem: CurrentWeatherItem?
        var insertCalled = false
        let loader = DefaultCurrentWeatherLoader(dataRemoteService: remoteLoader, dataLocalService: localLoader)
        let query = CurrentWeatherQuery(query: "Paris")
        
        // When
        localLoader.localInsertCalled = {
            insertCalled = true
        }
        
        loader.fetch(query: query) { result in
            expectedItem = try? result.get()
            expectation.fulfill()
        }
        
        // Then
        XCTAssertTrue(insertCalled)
        XCTAssertTrue(expectedItem != nil)
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_success_insert_items_after_fetch_multi_currentWeather() {
        // Given
        let expectation = self.expectation(description: "loader fetch items")
        expectation.expectedFulfillmentCount = 3
        let remoteLoader = RemoteDataServiceMock()
        let localLoader = CurrentWeatherStorage()
        var expectedItems =  [SearchSavedWeatherItem]()
        let loader = DefaultCurrentWeatherLoader(dataRemoteService: remoteLoader, dataLocalService: localLoader)
        let queryA = CurrentWeatherQuery(query: "Paris")
        let queryB = CurrentWeatherQuery(query: "Lille")
        
        // When
        loader.fetch(query: queryA) { result in
            expectation.fulfill()
        }
        
        loader.fetch(query: queryB) { result in
            expectation.fulfill()
        }
        
        loader.fetchAll { result in
            expectedItems = (try? result.get()) ?? []
            expectation.fulfill()
        } completion: {  result in
            print(result)
        }
        
        // Then
        XCTAssertTrue(expectedItems.count == 2)
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_fetch_get_stored_item_when_remote_fetch_failed() {
        // Given
        let expectation = self.expectation(description: "loader fetch items")
        expectation.expectedFulfillmentCount = 2
        let remoteLoader = RemoteDataServiceMock()
        let localLoader = CurrentWeatherStorage()
        var expectedItem: CurrentWeatherItem?
        let loader = DefaultCurrentWeatherLoader(dataRemoteService: remoteLoader, dataLocalService: localLoader)
        let query = CurrentWeatherQuery(query: "Paris")
        
        // When
        loader.fetch(query: query) { _ in
            expectation.fulfill()
        }
        
        //expect failure for remote loader
        remoteLoader.expectFailureReponse = true
        loader.fetch(query: query) { result in
            expectedItem = try? result.get()
            expectation.fulfill()
        }
        
        // Then
        XCTAssertTrue(expectedItem != nil)
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_do_not_call_local_loader_when_success_remote_loader() {
        // Given
        let expectation = self.expectation(description: "loader fetch items")
        expectation.expectedFulfillmentCount = 1
        let remoteLoader = RemoteDataServiceMock()
        let localLoader = CurrentWeatherStorage()
        let loader = DefaultCurrentWeatherLoader(dataRemoteService: remoteLoader, dataLocalService: localLoader)
        let query = CurrentWeatherQuery(query: "Paris")
        
        // When
        localLoader.localRetriveCalled = {
            XCTFail("local Retrive should not be called")
        }
        
        loader.fetch(query: query) { _ in
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 0.1)
    }

}
