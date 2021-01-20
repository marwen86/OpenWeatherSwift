//
//  DailyForecastViewController.swift
//  OpenWeather
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane. All rights reserved.  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import UIKit
import OpenWeatherCore

public protocol DailyForecastViewProtocol: class {
    var iconUseCase: GetIconUseCaseProtocol? { get }
    var interactor: HomeInteractorProtocol? { get }
    func set(ViewModels: [WeatherItemViewModel])
    func set(error: String)
    var city: String? { get }
}

public class DailyForecastViewController: UIViewController {
    public var city: String?
    
    public var iconUseCase: GetIconUseCaseProtocol?
    public var interactor: HomeInteractorProtocol?
    @IBOutlet private var tableView: UITableView!
    private var items: [WeatherItemViewModel] = []
    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = WeatherForecastItemCellTableViewCell.height
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        self.title = city?.capitalizingFirstLetter() ?? ""
        
        // register cell
        let bundle = Bundle(for: WeatherForecastItemCellTableViewCell.self)
        let nib = UINib(nibName: "WeatherForecastItemCellTableViewCell", bundle: bundle)
        tableView.register(nib, forCellReuseIdentifier: "WeatherForecastItemCellTableViewCell")
        
        //fetch data
        guard let city = city else { return }
        self.interactor?.fetchWeatherData(city: city)
        let add = UIBarButtonItem(barButtonSystemItem: .done,
                                  target: self,
                                  action: #selector(close))
        navigationItem.rightBarButtonItems = [add]
    }
    
    @IBAction func close() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DailyForecastViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
    public func set(ViewModels: [WeatherItemViewModel]) {
        //reload Data
        self.items = ViewModels
        tableView.reloadData()
    }
    
    public func set(error: String) {
        //show alert View With error description
    }
}
