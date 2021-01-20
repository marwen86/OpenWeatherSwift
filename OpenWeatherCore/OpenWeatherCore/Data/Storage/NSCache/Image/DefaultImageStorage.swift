//
//  DefaultImageStorage.swift
//  OpenWeather
//
//  Created by Youssef Marouane.
//  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation
class DefaultImageStorage: ImageStorage {
    private let queue = DispatchQueue(label: "\(DefaultImageStorage.self)Queue", qos: .userInitiated, attributes: .concurrent)
    private let cache: NSCache<NSString, NSData>
    
    private enum Error: Swift.Error {
        case notFound
        case badImageType
        case nameNotFound
    }
    
    init(cache: NSCache<NSString, NSData>) {
        self.cache = cache
    }
    
    func retrieve(dataForURL icon: String, completion: @escaping (RetrievalResult) -> Void) {
        let cache = self.cache
        queue.async {
            guard let img = cache.object(forKey: NSString(string: icon)) else {
                return completion(.failure(Error.notFound))
            }
            
            let data = img as Data
            let result: RetrievalResult = .success(data)
            completion(result)
        }
    }
    
    func insert(_ image: Data, for icon: String, completion: @escaping (InsertionResult) -> Void) {
        let imageData = image as NSData
        let cache = self.cache
        queue.async(flags: .barrier) {
            cache.setObject(imageData, forKey: NSString(string: icon))
            completion(.success(()))
        }
    }
}
