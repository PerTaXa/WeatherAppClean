//
//  TodayViewModel.swift
//  WeatherApp
//
//  Created by Aleksandre Pertaia on 28.11.21.
//

import Foundation

struct TodayViewModel {
    private let _iconName: String
    private let _coordinates: Coordinate
    private let _city: String
    private let _countryCode: String
    private let _temperature: Double
    private let _mainTheme: String
    private let _cloudiness: Int
    private let _humidity: Int
    private let _pressure: Double
    private let _windSpeed: Double
    private let _windDirection: Int?
    
    init(
        iconName: String,
        coordinates: Coordinate,
        city: String,
        countryCode: String,
        temperature: Double,
        mainTheme: String,
        cloudiness: Int,
        humidity: Int,
        pressure: Double,
        windSpeed: Double,
        windDirection: Int?
    ) {
        _iconName = iconName
        _coordinates = coordinates
        _city = city
        _countryCode = countryCode
        _temperature = temperature
        _mainTheme = mainTheme
        _cloudiness = cloudiness
        _humidity = humidity
        _pressure = pressure
        _windSpeed = windSpeed
        _windDirection = windDirection
    }
    
    init(from container: WeatherContainer) {
        _iconName = container.weather.first!.icon
        _coordinates = container.coord
        _city = container.name
        _countryCode = container.sys.country
        _temperature = container.main.temp
        _mainTheme = container.weather.first!.main
        _cloudiness = container.clouds.all
        _humidity = container.main.humidity
        _pressure = container.main.pressure
        _windSpeed = container.wind.speed
        _windDirection = container.wind.deg
    }
    
    var iconURL: String {
        return Constants.API.iconURL(for: _iconName)
    }
    
    var coordinates: Coordinate {
        return _coordinates
    }
    
    var todayWeather: String {
        return "\(Int(round(_temperature)))°C | \(_mainTheme)"
    }
    
    var place: String {
        return "\(_city), \(_countryCode)"
    }
    
    var cloudiness: String {
        return "\(_cloudiness) %"
    }
    
    var humidity: String {
        return "\(_humidity) mm"
    }
    
    var pressure: String {
        return "\(_pressure) hPa"
    }
    
    var windSpeed: String {
        return "\(_windSpeed) km/h"
    }
    
    var windDirection: String {
        return getDirection(from: _windDirection ?? 0)
    }
    
    private func getDirection(from angle: Int) -> String {
        let directions = ["N", "NW", "W", "SW", "S", "SE", "E", "NE"]
        let index = ((angle + 360) / 45) % 8
        return directions[index]
    }
}
