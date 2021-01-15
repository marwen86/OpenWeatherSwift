//
//  RemoteDataServiceTest.swift
//  OpenWeatherTests
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane. All rights reserved.  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import XCTest

class RemoteDataServiceTest: XCTestCase {
    
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
    
    struct NetworkServiceMock: NetworkService {
        var response: Result<Data?, NetworkError>
        func request(endpoint: Requestable, completion: @escaping CompletionHandler) {
            completion(response)
        }
    }
    
    func test_failed_empty_data_response() {
        let expectation = self.expectation(description: "search wetaher items")
        let endPoint = Endpoint(path: "codaway/get", method: .get)
        let networkService = NetworkServiceMock(response: .success(nil))
        let remoteDataService = RemoteDataService(with: networkService)
        remoteDataService.fetch(endpoint: endPoint) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch let error {
                if case RemoteDataError.noResponse = error {
                    expectation.fulfill()
                } else {
                    XCTFail("RemoteDataError.noResponse not found")
                }
            }
        }
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_failed_empty_data_not_dto() {
        let expectation = self.expectation(description: "search wetaher items")
        let endPoint = Endpoint(path: "codaway/get", method: .get)
        let networkService = NetworkServiceMock(response: .success("data".data(using: .utf8)))
        let remoteDataService = RemoteDataService(with: networkService)
        remoteDataService.fetch(endpoint: endPoint) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch let error {
                if case RemoteDataError.parsing = error {
                    expectation.fulfill()
                } else {
                     XCTFail("RemoteDataError.parsing not found")
                }
            }
        }
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_failed_network_error() {
        let expectation = self.expectation(description: "search wetaher items")
        let endPoint = Endpoint(path: "codaway/get", method: .get)
        let networkService = NetworkServiceMock(response: .failure(.error(statusCode: 400, data: nil)))
        let remoteDataService = RemoteDataService(with: networkService)
        remoteDataService.fetch(endpoint: endPoint) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch let error {
                if case RemoteDataError.generic = error {
                    expectation.fulfill()
                } else {
                      XCTFail("generic error network Not Found")
                }
            }
        }
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_succes_response() {
        let expectation = self.expectation(description: "search wetaher items")
        let endPoint = Endpoint(path: "codaway/get", method: .get)
        let responseData = #"{"city":{"id":2988507,"name":"Paris","coord":{"lon":2.3488,"lat":48.8534},"country":"FR","population":2138551,"timezone":7200},"cod":"200","message":0.0565995,"cnt":5,"list":[{"dt":1588849200,"sunrise":1588825192,"sunset":1588878863,"temp":{"day":294.13,"min":287.55,"max":294.13,"night":287.55,"eve":292.51,"morn":294.13},"feels_like":{"day":290.8,"night":285.74,"eve":289.75,"morn":290.8},"pressure":1022,"humidity":32,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"speed":2.78,"deg":91,"clouds":68}]}"#
        let networkService = NetworkServiceMock(response: .success(responseData.data(using: .utf8)))
        let remoteDataService = RemoteDataService(with: networkService)
        remoteDataService.fetch(endpoint: endPoint) { result in
            do {
                _ = try result.get()
                expectation.fulfill()
            } catch {
               XCTFail("wrong response")
            }
        }
        wait(for: [expectation], timeout: 0.1)
        
    }
    
}
