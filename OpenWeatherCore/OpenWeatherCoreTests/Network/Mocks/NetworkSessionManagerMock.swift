//
//  NetworkSessionManagerMock.swift
//  ExampleMVVMTests
//
//Copyright © 2021 Youssef Marouane.
//

import Foundation
@testable import OpenWeatherCore

struct NetworkSessionManagerMock: NetworkSessionManager {
    let response: HTTPURLResponse?
    let data: Data?
    let error: Error?
    
    func request(_ request: URLRequest,
                 completion: @escaping CompletionHandler) {
        completion(data, response, error)
    }
}
