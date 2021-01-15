//
//  ViewsBuilder.swift
//  OpenWeather
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane. All rights reserved.  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation

final class ViewsBuilder {
    
    static func makeCitiesView(useCases: OpenWeather.UseCases) -> CitiesListViewController {
        //Intercator
        let interactor = AddWeatherItemByCityInteractor(getWeatherUseCase: useCases.currentWeathersUseCase, addWeatherUserCase: useCases.addWeatherUseCase)
        
        //View
        let view = CitiesListViewController(nibName: "CitiesListViewController", bundle: nil)
       
        //Presenter
        let presenter = CitiesListViewPresenter()
        view.interactor = interactor
        presenter.view = view
        interactor.presenter = presenter
        view.iconUseCase = useCases.getIconUseCase
        return view
    }
    
    static func makeDailyForecastView(useCases: OpenWeather.UseCases, city: String) -> DailyForecastViewController {
        //Intercator
        let interactor = HomeInteractor(forecastUseCase: useCases.forecastUseCase)
        
        //View
        let view = DailyForecastViewController(nibName: "DailyForecastViewController", bundle: nil)
       
        //Presenter
        let presenter = DailyForecastViewPresenter()
        view.city = city
        view.interactor = interactor
        presenter.view = view
        interactor.presenter = presenter
        view.iconUseCase = useCases.getIconUseCase
        return view
    }
    
    static func makeDetail() -> DetailViewController {
        return DetailViewController(nibName: "DetailViewController", bundle: nil)
    }
}
