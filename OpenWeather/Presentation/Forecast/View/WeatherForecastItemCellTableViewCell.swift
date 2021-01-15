//
//  WeatherItemCellTableViewCell.swift
//  OpenWeather
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane. All rights reserved.  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import UIKit

protocol WeatherItemCellProtocol: class {
    var viewModel: WeatherItemViewModel? { get }
    var interactor: CellInteractorProtocol? { get }
    func set(imageView: Data)
}

class WeatherForecastItemCellTableViewCell: UITableViewCell {
    
    static func build(cell: WeatherForecastItemCellTableViewCell,
                      useCase: GetIconUseCaseProtocol,
                      viewModel: WeatherItemViewModel) {
        let presenter = WeatherForecastCellPresenter()
        let cellInteractor = CellInteractor(useCase: useCase)
        presenter.view = cell
        cellInteractor.presenter = presenter
        cell.interactor = cellInteractor
        cell.viewModel = viewModel
    }
    
    static let height = CGFloat(150)
    static let reuseIdentifier = String(describing: WeatherForecastItemCellTableViewCell.self)
    @IBOutlet private var mintempLabel: UILabel!
    @IBOutlet private var maxtempLabel: UILabel!
    @IBOutlet private var dayLabel: UILabel!
    @IBOutlet private var humidityLabel: UILabel!
    @IBOutlet private var iconImageView: UIImageView!
    
    var viewModel: WeatherItemViewModel?
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
        self.mintempLabel.text = self.viewModel?.maxTemp
        self.maxtempLabel.text = self.viewModel?.minTemp
        self.dayLabel.text = self.viewModel?.day
        self.humidityLabel.text = self.viewModel?.humidity
    }
    
}

extension WeatherForecastItemCellTableViewCell: WeatherItemCellProtocol {
    func set(imageView: Data) {
        self.iconImageView?.image = UIImage(data: imageView)
    }
}
