//
//  CurrentWeatherLoader+Mock.swift
//  OpenWeatherCoreTests
//
//  Created by Youssef Marouane on 20/01/2021.
//

import Foundation
@testable import OpenWeatherCore

struct CurrentWeatherLoaderMock: CurrentWeatherLoader {
    var fetchAllresponse: Result<[SearchSavedWeatherItem], Error>?
    var fetchResponse: Result<CurrentWeatherItem?, Error>?
    func fetchAll(cached: @escaping (fetchAllResult) -> Void, completion: @escaping (fetchAllResult) -> Void) {
        guard let fetchAllresponse = fetchAllresponse else { return }
        completion(fetchAllresponse)
    }
    
    func fetch(query: CurrentWeatherQuery,
               completion: @escaping (fetchResult) -> Void) {
        guard let fetchResponse = fetchResponse else { return }
        completion(fetchResponse)
    }
}
