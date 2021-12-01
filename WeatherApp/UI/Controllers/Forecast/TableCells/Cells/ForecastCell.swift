//
//  ForecastCell.swift
//  WeatherApp
//
//  Created by Aleksandre Pertaia on 29.11.21.
//

import UIKit
import SDWebImage

final class ForecastCell: UITableViewCell {
    
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var hourLabel: UILabel!
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func configure(with model: ForecastCellModel) {
        iconImage.sd_setImage(with: model.iconURL)
        hourLabel.text = model.hour
        weatherLabel.text = model.weather
        temperatureLabel.text = model.temperature
    }
}

struct ForecastCellModel {
    let iconURL: URL
    let hour: String
    let weather: String
    let temperature: String
    
    init(
        iconURL: URL,
        hour: String,
        weather: String,
        temperature: String
    ) {
        self.iconURL = iconURL
        self.hour = hour
        self.weather = weather
        self.temperature = temperature
    }
    
    init(forecast: Forecast) {
        let theme = forecast.weather[0]
        self.init(
            iconURL: URL(string: Constants.API.iconURL(for: theme.icon))!,
            hour: forecast.dt.toDate(format: "HH:mm"),
            weather: theme.description.capitalized,
            temperature: "\(Int(round(forecast.main.temp)))°C"
        )
    }
}

