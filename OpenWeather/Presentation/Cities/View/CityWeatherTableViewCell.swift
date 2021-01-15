//
//  CityWeatherTableViewCell.swift
//  OpenWeather
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import UIKit

protocol CityWeatherCellProtocol: class {
    var viewModel: SearchWeatherItemViewModel? { get }
    var interactor: CellInteractorProtocol? { get }
    func set(imageView: Data)
}

class CityWeatherTableViewCell: UITableViewCell {
    
    static func build(cell: CityWeatherTableViewCell,
                      useCase: GetIconUseCaseProtocol,
                      viewModel: SearchWeatherItemViewModel) {
        let presenter = WeatherCityCellPresenter()
        let cellInteractor = CellInteractor(useCase: useCase)
        presenter.view = cell
        cellInteractor.presenter = presenter
        cell.interactor = cellInteractor
        cell.viewModel = viewModel
    }
    
    static let height = CGFloat(150)
    static let reuseIdentifier = String(describing: CityWeatherTableViewCell.self)
    @IBOutlet private var mintempLabel: UILabel!
    @IBOutlet private var maxtempLabel: UILabel!
    @IBOutlet private var city: UILabel!
    @IBOutlet private var iconImageView: UIImageView!
    
    var viewModel: SearchWeatherItemViewModel?
    var interactor: CellInteractorProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func fill() {
        self.setupView()
        _ = viewModel?.image.flatMap{ self.interactor?.fetchIconData(iconName: $0) }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func setupView() {
        self.mintempLabel.text = self.viewModel?.minTemp
        self.maxtempLabel.text = self.viewModel?.maxTemp
        self.city.text = self.viewModel?.city.capitalizingFirstLetter()
    }
    
}

extension CityWeatherTableViewCell: CityWeatherCellProtocol {
    
    func set(imageView: Data) {
        self.iconImageView?.image = UIImage(data: imageView)
    }
}

