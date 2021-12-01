//
//  TodayPresenter.swift
//  WeatherApp
//
//  Created by Aleksandre Pertaia on 28.11.21.
//

import Foundation

protocol TodayPresenting: AnyObject {
    func handleWeatherData(_ result: Swift.Result<WeatherContainer, Error>)
    func startLoading()
}

final class TodayPresenter: TodayPresenting {
    
    weak var controller: TodayDisplaying?
    
    init(
        controller: TodayDisplaying
    ) {
        self.controller = controller
    }
    
    func startLoading() {
        controller?.startLoader()
    }
}

extension TodayPresenter {
    
    func handleWeatherData(_ result: Swift.Result<WeatherContainer, Error>) {
        switch result {
        case .success(let data):
            displayWeather(data)
        case .failure(let error):
            displayError(error.localizedDescription)
        }
    }
    
    private func displayWeather(_ container: WeatherContainer) {
        controller?.configure(with: TodayViewModel(from: container))
    }
    
    private func displayError(_ message: String) {
        controller?.showErrorView(with: message)
    }
}
