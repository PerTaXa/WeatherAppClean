//
//  Constants.swift
//  WeatherApp
//
//  Created by Aleksandre Pertaia on 28.11.21.
//

import Foundation
import UIKit

struct Constants {
    struct Storyboard{
        static let main = "Main"
    }
    
    struct API {
        static let apiKey = "ba093f9e5ed600e87203741347e4a135"
        static let baseURL = "api.openweathermap.org/data/2.5/"
        static var weatherURL: String { return "https://\(baseURL)weather?appid=\(apiKey)&units=metric" }
        static var forecastURL: String { return "https://\(baseURL)forecast?appid=\(apiKey)&units=metric" }
        
        static func iconURL(for name: String) -> String {
            return "https://openweathermap.org/img/wn/\(name)@2x.png"
        }
    }
    
    struct Color {
        static let accent = #colorLiteral(red: 1, green: 0.8, blue: 0.003921568627, alpha: 1)
    }
    
    struct Error {
        static let generalError = "Something went wrong!"
    }
    
    struct Tab {
        struct Today {
            static let title = "Today"
            static let image = UIImage(named: "tab_today")
        }
        struct Forecast {
            static let title = "Forecast"
            static let image = UIImage(named: "tab_forecast")
        }
    }
}
