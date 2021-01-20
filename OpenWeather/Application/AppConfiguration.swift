//
//  AppConfiguration.swift
//  CodawayGen
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane.
//

import Foundation
final class AppConfiguration {
    lazy var apiBaseURL: String = {
        return "https://api.openweathermap.org"
    }()
    
    lazy var iconBaseURL: String = {
          return "https://openweathermap.org"
      }()
    
    lazy var apiKey: String = {
        return "c258336f47350d8615f297197cba993a"
    }()
}
