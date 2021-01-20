//
//  WeatherItemCellPresenter.swift
//  OpenWeather
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane. All rights reserved.  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation

public protocol CellIconPresenterProtocol : class {
    func interactor(_ interactor: CellInteractorProtocol, didFetch image: Data)
}

public class WeatherForecastCellPresenter {

    public weak var view: WeatherItemCellProtocol?
}

extension WeatherForecastCellPresenter: CellIconPresenterProtocol {

    public func interactor(_ interactor: CellInteractorProtocol, didFetch image: Data) {
        DispatchQueue.main.async { self.view?.set(imageView: image) }
        
    }
}
