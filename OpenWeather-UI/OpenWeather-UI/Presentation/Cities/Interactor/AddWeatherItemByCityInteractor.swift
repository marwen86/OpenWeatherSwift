//
//  AddWeatherItemByCityInteractor.swift
//  OpenWeather
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation
import OpenWeatherCore

public protocol AddWeatherItemByCityInteractorProtocol {
    func fetchWeatherData(city: String)
    func allCitiesWeather()
}

public class AddWeatherItemByCityInteractor: AddWeatherItemByCityInteractorProtocol, HomeInteractorProtocol {
    private let getWeatherUseCase: SavedWeathersUseCaseProtocol
    private let addWeatherUserCase: AddWeatherUseCaseProtocol
    public var presenter: CitiesListViewPresenterProtocol?
    
    public init(getWeatherUseCase: SavedWeathersUseCaseProtocol, addWeatherUserCase: AddWeatherUseCaseProtocol) {
        self.getWeatherUseCase = getWeatherUseCase
        self.addWeatherUserCase = addWeatherUserCase
    }
    
    public func allCitiesWeather() {
        func hundleErrorResponse(error: Error) {
            //call error Delegate
            presenter?.interactor(self, didFailWith: error)
        }
        
        func handleSuccessResponse(items: [SearchSavedWeatherItem]) {
            //call delegate to refresh VC
            presenter?.interactor(self, didFetch: items)
        }
        
        self.getWeatherUseCase.execute { result in
            do {
                let items = try result.get()
                handleSuccessResponse(items: items)
            } catch {
                hundleErrorResponse(error: error)
            }
        }
    }
    
    public func fetchWeatherData(city: String) {
        func hundleErrorResponse(error: Error) {
            //call error Delegate
            presenter?.interactor(self, didFailWith: error)
        }
        
        func handleSuccessResponse(item: CurrentWeatherItem) {
            //call delegate to refresh VC
            presenter?.interactor(self, didFetch: item)
        }
        
        
        self.addWeatherUserCase.execute(city: city, completion: { result in
            do {
                if let item = try result.get() {
                    handleSuccessResponse(item: item)
                }
            } catch {
                hundleErrorResponse(error: error)
            }
        })
    }
}
