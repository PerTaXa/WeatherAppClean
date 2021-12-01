//
//  TodayInteractor.swift
//  WeatherApp
//
//  Created by Aleksandre Pertaia on 28.11.21.
//

import Foundation
import Alamofire

typealias WeatherCompletion = (Result<WeatherContainer, Error>) -> ()

protocol TodayInteracting: Interactor {
    func loadWeatherData()
}

final class TodayInteractor: TodayInteracting {
    
    let presenter: TodayPresenting
    let locationManager: LocationManager = .init()
    
    init(
        presenter: TodayPresenting
    ) {
        self.presenter = presenter
        self.locationManager.delegate = self
    }
    
    func loadWeatherData() {
        presenter.startLoading()
        locationManager.requestLocation()
    }
        
    private func loadWeather(for coordinates: Coordinate, completion: @escaping WeatherCompletion) {
        let parameters = [
            "lat": coordinates.lat,
            "lon": coordinates.lon
        ]
    
        AF.request(
            Constants.API.weatherURL,
            parameters: parameters
        ).responseData { [weak self] response in
            self?.parse(response, completion: completion)
        }
    }
    
}

extension TodayInteractor: LocationManagerDelegate {
    
    func locationManagerdidAllowLocation(_ sender: LocationManager) {
        self.loadWeatherData()
    }
    
    func locationManager(_ sender: LocationManager, didRetrieve locationData: LocationData) {
        loadWeather(
            for: locationData.coordinates,
            completion: { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.presenter.handleWeatherData(result)
                }
            }
        )
    }
    
    func locationManager(_ sender: LocationManager, didFailWith failure: String) {
        presenter.handleWeatherData(.failure(NSError(domain: failure, code: 404, userInfo: nil)))
    }
}
