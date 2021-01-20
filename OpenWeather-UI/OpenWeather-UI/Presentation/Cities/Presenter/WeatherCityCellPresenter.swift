//
//  WeatherCityCellPresenter.swift
//  OpenWeather
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation

public class WeatherCityCellPresenter {

    public weak var view: CityWeatherCellProtocol?
}

extension WeatherCityCellPresenter: CellIconPresenterProtocol {

    public func interactor(_ interactor: CellInteractorProtocol, didFetch image: Data) {
        DispatchQueue.main.async { self.view?.set(imageView: image) }
        
    }
}
