//
//  ForecastInteractor.swift
//  WeatherApp
//
//  Created by Aleksandre Pertaia on 29.11.21.
//

import Foundation
import Alamofire

typealias ForecastCompletion = (Swift.Result<ForecastContainer, Error>) -> ()

protocol ForecastInteracting: Interactor {
    func loadForecastData()
}

final class ForecastInteractor: ForecastInteracting {
    
    let presenter: ForecastPresenting
    let locationManager: LocationManager = .init()
    
    init(
        presenter: ForecastPresenting
    ) {
        self.presenter = presenter
        self.locationManager.delegate = self
    }
    
    
    func loadForecastData() {
        presenter.startLoading()
        locationManager.requestLocation()
    }
    
    private func loadForecast(for coordinates: Coordinate, completion: @escaping ForecastCompletion) {
        let parameters = [
            "lat": coordinates.lat,
            "lon": coordinates.lon
        ]
        AF.request(
            Constants.API.forecastURL,
            parameters: parameters
        ).responseData { [weak self] response in
            self?.parse(response, completion: completion)
        }
    }
}

extension ForecastInteractor: LocationManagerDelegate {
    func locationManagerdidAllowLocation(_ sender: LocationManager) {
        self.loadForecastData()
    }
    
    func locationManager(_ sender: LocationManager, didRetrieve locationData: LocationData) {
        loadForecast(
            for: locationData.coordinates,
            completion: { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.presenter.handleForecastData(result)
                }
            }
        )
    }
    
    func locationManager(_ sender: LocationManager, didFailWith failure: String) {
        presenter.handleForecastData(.failure(NSError(domain: failure, code: 404, userInfo: nil)))
    }
}
