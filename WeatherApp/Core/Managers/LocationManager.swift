//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Aleksandre Pertaia on 28.11.21.
//

import CoreLocation

struct LocationData {
    let location: CLLocation
    
    var coordinates: Coordinate {
        return Coordinate(
            lat: location.coordinate.latitude,
            lon: location.coordinate.longitude
        )
    }
}

protocol LocationManagerDelegate: AnyObject {
    func locationManagerdidAllowLocation(_ sender: LocationManager)
    func locationManager(_ sender: LocationManager, didRetrieve locationData: LocationData)
    func locationManager(_ sender: LocationManager, didFailWith failure: String)
}

final class LocationManager: NSObject {
    
    private let manager = CLLocationManager()
    private var locationRetrieved = false
    
    weak var delegate: LocationManagerDelegate?
    
    var locationData: LocationData?
    
    override init() {
        super.init()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        manager.distanceFilter = kCLDistanceFilterNone
        manager.activityType = .other
    }
    
    func requestLocation() {
        locationRetrieved = false
        manager.requestLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            delegate?.locationManagerdidAllowLocation(self)
        default:
            delegate?.locationManager(self, didFailWith: Constants.Error.generalError)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard locationRetrieved == false else { return }
        if let location = locations.first {
            locationRetrieved = true
            self.locationData = LocationData(location: location)
            self.delegate?.locationManager(self, didRetrieve: locationData!)
        } else {
            delegate?.locationManager(self, didFailWith: Constants.Error.generalError)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.locationManager(self, didFailWith: Constants.Error.generalError)
    }
}
