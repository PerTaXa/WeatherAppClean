//
//  ForecastPresenter.swift
//  WeatherApp
//
//  Created by Aleksandre Pertaia on 29.11.21.
//

import Foundation

protocol ForecastPresenting: AnyObject {
    func startLoading()
    func handleForecastData(_ result: Swift.Result<ForecastContainer, Error>)
}

final class ForecastPresenter: ForecastPresenting {
    
    weak var controller: ForecastDisplaying?
    
    init(
        controller: ForecastDisplaying
    ) {
        self.controller = controller
    }
 
    func startLoading() {
        controller?.startLoader()
    }
}

extension ForecastPresenter {
    
    
    func handleForecastData(_ result: Swift.Result<ForecastContainer, Error>) {
        switch result {
        case .success(let data):
            displayForecast(data)
        case .failure(let error):
            displayError(error.localizedDescription)
        }
    }
    
    private func displayForecast(_ container: ForecastContainer) {
        controller?.configure(with: ForecastViewModel(from: container))
    }
    
    private func displayError(_ message: String) {
        controller?.showErrorView(with: message)
    }
}
