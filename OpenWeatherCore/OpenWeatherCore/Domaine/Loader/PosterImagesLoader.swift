//
//  PosterImagesRepository.swift
//  CodawayGen
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane. All rights reserved.  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation
protocol PosterImagesLoader {
    typealias fetchResult = Swift.Result<Data, Error>
    
    func fetch(with icon: String, completion: @escaping (fetchResult) -> Void)
}
