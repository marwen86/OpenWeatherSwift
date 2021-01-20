//
//  ViewsBuilder.swift
//  OpenWeather
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane.
//

import Foundation

final class ViewsBuilder {
    
    static func makeCitiesView(useCases: OpenWeather.UseCases) -> CitiesListViewController {
        //Intercator
        let interactor = AddWeatherItemByCityInteractor(getWeatherUseCase: useCases.savedcurrentWeathersUseCase, addWeatherUserCase: useCases.addWeatherUseCase)
        
        //View
        let bundle = Bundle(for: CitiesListViewController.self)
        let view = CitiesListViewController(nibName: "CitiesListViewController", bundle: bundle)
       
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
        let bundle = Bundle(for: DailyForecastViewController.self)
        let view = DailyForecastViewController(nibName: "DailyForecastViewController", bundle: bundle)
       
        //Presenter
        let presenter = DailyForecastViewPresenter()
        view.city = city
        view.interactor = interactor
        presenter.view = view
        interactor.presenter = presenter
        view.iconUseCase = useCases.getIconUseCase
        return view
    }
    
    static func makeDetail(useCases: OpenWeather.UseCases,city:String) -> DetailViewController {
        //Intercator
        let interactor = DetailViewInteractor(iconUseCase: useCases.getIconUseCase, itemUseCase: useCases.fetchWeather)
        
        //View
        let bundle = Bundle(for: DetailViewController.self)
        let view = DetailViewController(nibName: "DetailViewController", bundle: bundle)
       
        //Presenter
        let presenter = WeatherDetailViewPresenter()
        view.city = city
        view.interactor = interactor
        presenter.view = view
        interactor.presenter = presenter
        return view
    }
}
