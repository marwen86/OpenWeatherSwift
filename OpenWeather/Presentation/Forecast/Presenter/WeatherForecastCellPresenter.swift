//
//  WeatherItemCellPresenter.swift
//  OpenWeather
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane. All rights reserved.  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation

protocol CellIconPresenterProtocol : class {
    func interactor(_ interactor: CellInteractorProtocol, didFetch image: Data)
}

class WeatherForecastCellPresenter {

    weak var view: WeatherItemCellProtocol?
}

extension WeatherForecastCellPresenter: CellIconPresenterProtocol {

    func interactor(_ interactor: CellInteractorProtocol, didFetch image: Data) {
        DispatchQueue.main.async { self.view?.set(imageView: image) }
        
    }
}
