//
//  ForecastHeader.swift
//  WeatherApp
//
//  Created by Aleksandre Pertaia on 29.11.21.
//

import UIKit

final class ForecastHeader: UITableViewHeaderFooterView {
    
    
    @IBOutlet weak var headerLabel: UILabel!
    
    func configure(with model: ForecastHeaderModel) {
        headerLabel.text = model.title
    }
}

struct ForecastHeaderModel {
    let title: String
    
    init(title: String) {
        self.title = title.uppercased()
    }
}
