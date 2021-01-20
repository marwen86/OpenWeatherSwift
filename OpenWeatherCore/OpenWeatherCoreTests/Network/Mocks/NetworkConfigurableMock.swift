//
//  NetworkServiceMocks.swift
//  ExampleMVVMTests
//
//Copyright © 2021 Youssef Marouane.
//

import Foundation
@testable import OpenWeatherCore

class NetworkConfigurableMock: NetworkConfigurable {
    var baseURL: URL = URL(string: "https://mock.test.com")!
    var headers: [String: String] = [:]
    var queryParameters: [String: String] = [:]
}
