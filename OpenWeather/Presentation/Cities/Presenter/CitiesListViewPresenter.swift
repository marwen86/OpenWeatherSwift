//
//  CitiesListViewPresenter.swift
//  OpenWeather
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation

struct SearchWeatherItemViewModel {
    let maxTemp: String
    let minTemp : String
    let city: String
    let image: String?
}



protocol CitiesListViewPresenterProtocol {
    func interactor(_ interactor: HomeInteractorProtocol, didFetch object: CurrentWeatherItem)
    func interactor(_ interactor: HomeInteractorProtocol, didFailWith error: Error)
    func interactor(_ interactor: HomeInteractorProtocol, didFetch objects: [SearchSavedWeatherItem])
}

class CitiesListViewPresenter: CitiesListViewPresenterProtocol {
    weak var view: CitiesListViewProtocol?
    private func buildViewModel(item: SearchSavedWeatherItem) -> SearchWeatherItemViewModel {
        return SearchWeatherItemViewModel(maxTemp: "\(String(format:"%.0f", item.weather?.tempMax.kelvinToDeg ?? 0))°",
                                          minTemp: "\(String(format:"%.0f", item.weather?.tempMin.kelvinToDeg ?? 0))°",
                                           city: item.city ?? "",
                                           image: item.weather?.weather.first?.icon)
    }
}

extension CitiesListViewPresenter {
    func interactor(_ interactor: HomeInteractorProtocol, didFetch object: CurrentWeatherItem) {
        DispatchQueue.main.async {
            self.view?.didAddCityWeatherWithSuccess()
        }
    }
    func interactor(_ interactor: HomeInteractorProtocol, didFailWith error: Error) {
        DispatchQueue.main.async { self.view?.set(error: error.localizedDescription) }
    }
    func interactor(_ interactor: HomeInteractorProtocol, didFetch objects: [SearchSavedWeatherItem]) {
        DispatchQueue.main.async { self.view?.set(ViewModels:  objects.map {
            self.buildViewModel(item: $0)
        })
        }
    }
}
