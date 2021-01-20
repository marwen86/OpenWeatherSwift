//
//  DetailViewController.swift
//  OpenWeather
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane. All rights reserved.  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import UIKit
public protocol WeatherDetailViewProtocol: class {
    func set(currentWeather: CurrentWeatherItemViewModel)
    func set(iconWeather: UIImage?)
    var onShowForeCast: ((String) -> Void)? { get }
}

public class DetailView: UIView {
    @IBOutlet private var city: UILabel!
    @IBOutlet private var temp: UILabel!
    @IBOutlet private var icon: UIImageView!
    @IBOutlet private var visibility: UILabel!
    @IBOutlet private var feelsLike: UILabel!
    @IBOutlet private var tempMin: UILabel!
    @IBOutlet private var tempMax: UILabel!
    @IBOutlet private var pressure: UILabel!
    @IBOutlet private var humidity: UILabel!
    @IBOutlet private var speed: UILabel!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateIcon(icon: UIImage) {
        self.icon.image = icon
    }
    
    func updateView(model: CurrentWeatherItemViewModel) {
        self.temp.text = model.temp
        self.visibility.text = model.visibility
        self.feelsLike.text = model.feelsLike
        self.tempMin.text = model.tempMin
        self.tempMax.text = model.tempMax
        self.pressure.text = model.pressure
        self.humidity.text = model.humidity
        self.speed.text = model.speed
    }
    
    func updateCityTitle(city: String) {
        self.city.text = city
    }
}

public class DetailViewController: UIViewController {
    @IBOutlet private var detailView: DetailView!
    public var onShowForeCast: ((String) -> Void)?
    public var city: String?
    public var interactor: DetailViewInteractorProtocol?
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let add = UIBarButtonItem(title: "Prévisions",
                                  style: .plain,
                                  target: self,
                                  action: #selector(showForecast))
        navigationItem.rightBarButtonItems = [add]
        // Do any additional setup after loading the view.
        guard let city = city else { return }
        interactor?.fetchDetailData(city: city)
    }
    
    @IBAction func showForecast(_ sender: Any) {
        guard let city = city else { return }
        self.onShowForeCast?(city)
    }
    
    private func setupView(model: CurrentWeatherItemViewModel) {
        self.detailView.updateView(model: model)
        self.detailView.updateCityTitle(city: city?.capitalizingFirstLetter() ?? "Paris")
    }
    
    private func updateIcon(image: UIImage) {
        self.detailView.updateIcon(icon: image)
    }
}

extension DetailViewController: WeatherDetailViewProtocol {
    public func set(currentWeather: CurrentWeatherItemViewModel) {
        // update View
        self.setupView(model: currentWeather)
        interactor?.fetchIconData(iconName: currentWeather.icon)
    }
    
    public func set(iconWeather: UIImage?) {
        // update icon
        guard let iconWeather = iconWeather else { return }
        self.updateIcon(image: iconWeather)
    }
}
