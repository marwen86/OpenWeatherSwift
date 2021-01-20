//
//  CellInteractor.swift
//  OpenWeather
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane.
//

import Foundation
import OpenWeatherCore

public protocol CellInteractorProtocol {
    var presenter: CellIconPresenterProtocol? { get set}
    func fetchIconData(iconName: String)
}
public class CellInteractor: CellInteractorProtocol {
    public var presenter: CellIconPresenterProtocol?
    private let useCase: GetIconUseCaseProtocol
    public init(useCase: GetIconUseCaseProtocol) {
        self.useCase = useCase
    }
    
    public func fetchIconData(iconName: String) {
        self.useCase.execute(icon: iconName) { result in
            do {
                let data = try result.get()
                self.presenter?.interactor(self, didFetch: data)
            } catch {
                print("pb when downlaod icon")
            }
        }
    }
}
