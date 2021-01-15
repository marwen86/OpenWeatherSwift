//
//  CellInteractor.swift
//  OpenWeather
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane. All rights reserved.  Copyright © 2021 Youssef Marouane. All rights reserved.
//

import Foundation

protocol CellInteractorProtocol {
    var presenter: CellIconPresenterProtocol? { get set}
    func fetchIconData(iconName: String)
}
class CellInteractor: CellInteractorProtocol {
    var presenter: CellIconPresenterProtocol?
    private let useCase: GetIconUseCaseProtocol
    init(useCase: GetIconUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func fetchIconData(iconName: String) {
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
