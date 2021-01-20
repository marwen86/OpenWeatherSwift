//
//  DetailItemView.swift
//  OpenWeather
//
//  Created by Youssef Marouane.
//  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import UIKit

public class DetailItemView: UIView {
    
    @IBOutlet private var desc: UILabel!
    @IBOutlet private var icon: UIImageView!
    @IBOutlet private var visibility: UILabel!
    @IBOutlet private var clouds: UILabel!
    @IBOutlet private var temp: UILabel!
    @IBOutlet private var feelsLike: UILabel!
    @IBOutlet private var tempMin: UILabel!
    @IBOutlet private var tempMax: UILabel!
    @IBOutlet private var pressure: UILabel!
    @IBOutlet private var humidity: UILabel!
    @IBOutlet private var speed: UILabel!
    @IBOutlet private var deg: UILabel!

    public var viewModel: String?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
}
