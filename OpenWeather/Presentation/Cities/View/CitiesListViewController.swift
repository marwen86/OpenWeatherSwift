//
//  CitiesListViewController.swift
//  OpenWeather
//
//  Created by Youssef Marouane on 07/01/2021.
//  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import UIKit

protocol CitiesListViewProtocol: class {
    var iconUseCase: GetIconUseCaseProtocol? { get }
    var interactor: AddWeatherItemByCityInteractorProtocol? { get }
    func set(ViewModels: [SearchWeatherItemViewModel])
    func didAddCityWeatherWithSuccess()
    func set(error: String)
    var onShowDetail: ((String) -> Void)? { get }
    var onShowForeCast: ((String) -> Void)? { get }
}

class CitiesListViewController: UIViewController {
    var onShowDetail: ((String) -> Void)?
    var onShowForeCast: ((String) -> Void)?
    var interactor: AddWeatherItemByCityInteractorProtocol?
    var iconUseCase: GetIconUseCaseProtocol?
    @IBOutlet private var tableView: UITableView!
    private var items: [SearchWeatherItemViewModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = WeatherForecastItemCellTableViewCell.height
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        self.title = "Welcome"
        
        // register cell
        let nib = UINib(nibName: "CityWeatherTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CityWeatherTableViewCell")
        
        //fetch data
        self.interactor?.allCitiesWeather()
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCity))
        navigationItem.rightBarButtonItems = [add]
    }

    @IBAction func addCity(_ sender: Any) {
        let alert = UIAlertController(title: "Ajouter", message: "Sasir la ville", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Paris"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let viewModel = items[indexPath.row]
        self.onShowForeCast?(viewModel.city)
    }
    
}

extension CitiesListViewController: CitiesListViewProtocol {
    func set(ViewModels: [SearchWeatherItemViewModel]) {
        //refresh tableview with all cities Weather
        self.items = ViewModels
        tableView.reloadData()
    }
    
    func didAddCityWeatherWithSuccess() {
        //show alert success add new city
        self.interactor?.allCitiesWeather()
        let alert = UIAlertController(title: "Sucées", message: String(format: "ajouté avec succès sur votre liste."), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func set(error: String) {
        // show error message
        let alert = UIAlertController(title: "Erreur", message: "Le nom de la ville n'existait pas sur notre base de données, veuillez ressayer avec une ville.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}


