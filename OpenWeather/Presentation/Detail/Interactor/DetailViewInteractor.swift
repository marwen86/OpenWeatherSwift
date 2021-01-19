//
//  DetailViewInteractor.swift
//  OpenWeather
//
//  Created by Youssef Marouane on 19/01/2021.
//  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation
protocol DetailViewInteractorProtocol {
    var presenter: WeatherDetailViewPresenterProtocol? { get set}
    func fetchIconData(iconName: String)
    func fetchDetailData(city: String)
}
class DetailViewInteractor: DetailViewInteractorProtocol {
   
    var presenter: WeatherDetailViewPresenterProtocol?
    private let iconUseCase: GetIconUseCaseProtocol
    private let itemUseCase: FetchWeatherUseCaseProtocol
    init(iconUseCase: GetIconUseCaseProtocol, itemUseCase: FetchWeatherUseCaseProtocol) {
        self.iconUseCase = iconUseCase
        self.itemUseCase = itemUseCase
    }
    
    func fetchIconData(iconName: String) {
        self.iconUseCase.execute(icon: iconName) { result in
            do {
                let data = try result.get()
                self.presenter?.interactor(self, didFetch: data)
            } catch {
                print("pb when downlaod icon")
            }
        }
    }
    
    func fetchDetailData(city: String) {
        self.itemUseCase.execute(query: city) { result in
            do {
                guard let item = try result.get() else {
                    print("pb when downlaod item")
                    return 
                }
                self.presenter?.interactor(self, didFetch: item)
            } catch {
                print("pb when downlaod item")
            }
        }
    }
}
