//
//  String+Localized.swift
//  OpenWeather-UI
//
//  Created by Youssef Marouane on 22/01/2021.
//

import Foundation

extension String {
    var textKey: String {
        return NSLocalizedString(self,
                tableName: "OpenWeather",
                bundle: Bundle(for: CitiesListViewController.self),
                comment: "Error message displayed when we can't load the image feed from the server")
    }
}
