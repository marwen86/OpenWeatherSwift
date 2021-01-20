//
//  ForecastWeatherLoader+Mock.swift
//  OpenWeatherCoreTests
//
//  Created by Youssef Marouane on 20/01/2021.
//

import Foundation
@testable import OpenWeatherCore

struct ForecastLoaderMock: ForecastWeatherLoader {
    
    var remoteResponse: Result<[ForecastItem], Error>
    var cachResponse: Result<[ForecastItem], Error>
    func fetch(query: ForecastWeatherQuery,
               cached: @escaping (fetchResult) -> Void,
               completion: @escaping (fetchResult) -> Void) {
        cached(cachResponse)
        completion(remoteResponse)
    }
}
