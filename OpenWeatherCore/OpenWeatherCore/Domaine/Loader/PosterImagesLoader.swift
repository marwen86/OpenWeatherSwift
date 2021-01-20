//
//  PosterImagesRepository.swift
//  CodawayGen
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane.
//

import Foundation
protocol PosterImagesLoader {
    typealias fetchResult = Swift.Result<Data, Error>
    
    func fetch(with icon: String, completion: @escaping (fetchResult) -> Void)
}
