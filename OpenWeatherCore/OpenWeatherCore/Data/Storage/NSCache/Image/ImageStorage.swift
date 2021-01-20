//
//  ImageStorage.swift
//  OpenWeather
//
//  Created by Youssef Marouane.
//  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation
protocol ImageStorage {
        typealias RetrievalResult = Swift.Result<Data?, Error>
        typealias InsertionResult = Swift.Result<Void, Error>

        func insert(_ image: Data, for icon: String, completion: @escaping (InsertionResult) -> Void)
        func retrieve(dataForURL icon: String, completion: @escaping (RetrievalResult) -> Void)
}
