//
//  DailyForecastViewController.swift
//  OpenWeather
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane. All rights reserved.  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import UIKit

protocol DailyForecastViewProtocol: class {
    var iconUseCase: GetIconUseCaseProtocol? { get }
    var interactor: HomeInteractorProtocol? { get }
    func set(ViewModels: [WeatherItemViewModel])
    func set(error: String)
    var city: String? { get }
}

class DailyForecastViewController: UIViewController {
    var city: String?
  
    var iconUseCase: GetIconUseCaseProtocol?
    var interactor: HomeInteractorProtocol?
    @IBOutlet private var tableView: UITableView!
    private var items: [WeatherItemViewModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = WeatherForecastItemCellTableViewCell.height
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        self.title = city?.capitalizingFirstLetter() ?? ""
        
        // register cell
        let nib = UINib(nibName: "WeatherForecastItemCellTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "WeatherForecastItemCellTableViewCell")
        
        //fetch data
        guard let city = city else { return }
        self.interactor?.fetchWeatherData(city: city)
    }
}

extension DailyForecastViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherForecastItemCellTableViewCell.reuseIdentifier, for: indexPath) as? WeatherForecastItemCellTableViewCell else {
            fatalError("Cannot dequeue reusable cell \(WeatherForecastItemCellTableViewCell.self) with reuseIdentifier: \(WeatherForecastItemCellTableViewCell.reuseIdentifier)")
        }
        guard let iconUseCase = iconUseCase else { return cell }
        WeatherForecastItemCellTableViewCell.build(cell: cell,
                                                   useCase: iconUseCase,
                                                   viewModel: items[indexPath.row])
        cell.fill()
        return cell
    }
    
}

extension DailyForecastViewController: DailyForecastViewProtocol {
    func set(ViewModels: [WeatherItemViewModel]) {
        //reload Data
        self.items = ViewModels
        tableView.reloadData()
    }
    
    func set(error: String) {
        //show alert View With error description
    }
}
