//
//  Network+Mock.swift
//  OpenWeatherCoreTests
//
//  Created by Youssef Marouane on 21/01/2021.
//

import Foundation
@testable import OpenWeatherCore
struct EndpointMock: Requestable {
    var path: String
    var isFullPath: Bool = false
    var method: HTTPMethodType
    var headerParamaters: [String: String] = [:]
    var queryParametersEncodable: Encodable?
    var queryParameters: [String: Any] = [:]
    var bodyParamatersEncodable: Encodable?
    var bodyParamaters: [String: Any] = [:]
    var bodyEncoding: BodyEncoding = .stringEncodingAscii
    
    init(path: String, method: HTTPMethodType) {
        self.path = path
        self.method = method
    }
}

class NetworkErrorLoggerMock: NetworkErrorLogger {
    var loggedErrors: [Error] = []
    func log(request: URLRequest) { }
    func log(responseData data: Data?, response: URLResponse?) { }
    func log(error: Error) { loggedErrors.append(error) }
}

enum NetworkErrorMock: Error {
    case someError
}
