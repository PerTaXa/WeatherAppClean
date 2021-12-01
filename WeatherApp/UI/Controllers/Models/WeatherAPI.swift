//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Aleksandre Pertaia on 28.11.21.
//

import Foundation

struct WeatherContainer: Codable {
    let coord: Coordinate
    let weather: [Weather]
    let base: String
    let main: Main
    let wind: Wind
    let clouds: Clouds
    let dt: Int64
    let sys: Sys
    let id: Int64
    let name: String
    let cod: Int
}

struct Coordinate: Codable {
    let lat: Double
    let lon: Double
}

struct Weather: Codable {
    let id: Int64
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double
    let pressure: Double
    let humidity: Int
}

struct Wind: Codable {
    let speed: Double
    let deg: Int?
}

struct Clouds: Codable {
    let all: Int
}

struct Sys: Codable {
    let message: Double?
    let country: String
}


struct ForecastContainer: Codable {
    let cod: String
    let message: Double
    let cnt: Int
    let list: [Forecast]
    let city: City
}

struct Forecast: Codable {
    let dt: Double
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
}

struct City: Codable {
    let name: String
    let coord: Coordinate
    let country: String
}
