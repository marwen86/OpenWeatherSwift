//
//  CitiesListViewController.swift
//  OpenWeather
//
//  Created by Youssef Marouane.
//  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import UIKit
import OpenWeatherCore

public protocol CitiesListViewProtocol: class {
    var iconUseCase: GetIconUseCaseProtocol? { get }
    var interactor: AddWeatherItemByCityInteractorProtocol? { get }
    func set(ViewModels: [SearchWeatherItemViewModel])
    func didAddCityWeatherWithSuccess()
    func set(error: String)
    var onShowDetail: ((String) -> Void)? { get }
    var onShowForeCast: ((String) -> Void)? { get }
}

public class CitiesListViewController: UIViewController {
    public var onShowDetail: ((String) -> Void)?
    public var onShowForeCast: ((String) -> Void)?
    public var interactor: AddWeatherItemByCityInteractorProtocol?
    public var iconUseCase: GetIconUseCaseProtocol?
    @IBOutlet private var tableView: UITableView!
    private var items: [SearchWeatherItemViewModel] = []
    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = WeatherForecastItemCellTableViewCell.height
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        self.title = "HOME_TITLE".textKey
        
        // register cell
        let bundle = Bundle(for: CityWeatherTableViewCell.self)
        let nib = UINib(nibName: "CityWeatherTableViewCell", bundle: bundle)
        tableView.register(nib, forCellReuseIdentifier: "CityWeatherTableViewCell")
        
        //fetch data
        self.interactor?.allCitiesWeather()
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCity))
        navigationItem.rightBarButtonItems = [add]
    }

    @IBAction func addCity(_ sender: Any) {
        let alert = UIAlertController(title: "COMMON_ADD".textKey, message:"ADD_CITY_WEATHER_TITLE".textKey, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "ADD_CITY_PLACEHOLDER".textKey
        }
        
        alert.addAction(UIAlertAction(title: "COMMON_OK".textKey, style: .default, handler: { [weak alert] (_) in
            
            guard let alert = alert,
                  let textFields = alert.textFields,
                  let textField = textFields.first, let cityName = textField.text else {
                return
            }
            self.interactor?.fetchWeatherData(city: cityName)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension CitiesListViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityWeatherTableViewCell.reuseIdentifier, for: indexPath) as? CityWeatherTableViewCell else {
            fatalError("Cannot dequeue reusable cell \(CityWeatherTableViewCell.self) with reuseIdentifier: \(CityWeatherTableViewCell.reuseIdentifier)")
        }
        guard let iconUseCase = iconUseCase else { return cell }
        CityWeatherTableViewCell.build(cell: cell,
                                       useCase: iconUseCase,
                                       viewModel: items[indexPath.row])
        cell.fill()
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let viewModel = items[indexPath.row]
        self.onShowDetail?(viewModel.city)
    }
    
}

extension CitiesListViewController: CitiesListViewProtocol {
    public func set(ViewModels: [SearchWeatherItemViewModel]) {
        //refresh tableview with all cities Weather
        self.items = ViewModels
        tableView.reloadData()
    }
    
    public func didAddCityWeatherWithSuccess() {
        //show alert success add new city
        self.interactor?.allCitiesWeather()
        let alert = UIAlertController(title: "COMMON_SUCCESS".textKey,
                                      message: "ADD_WEATHER_SUCCESS_MESSAGE".textKey,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "COMMON_OK".textKey,
                                      style: .cancel,
                                      handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    public func set(error: String) {
        // show error message
        let alert = UIAlertController(title: "COMMON_ERROR".textKey,
                                      message: "ADD_WEATHER_ERROR_MESSAGE".textKey,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "COMMON_OK".textKey, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


