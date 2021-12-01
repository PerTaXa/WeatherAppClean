//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Aleksandre Pertaia on 29.11.21.
//

import Foundation

struct ForecastViewModel {
    lazy var sectionModels = [ForecastSectionViewModel]()
    
    init() {
        sectionModels = []
    }
    
    init(from container: ForecastContainer) {
        for forecast in container.list {
            let weekday = forecast.dt.toDate(format: "EEEE").uppercased()
            if let section = sectionModels.first(where: {$0.headerModel.title == weekday}) {
                section.cellModels.append(ForecastCellModel(forecast: forecast))
            } else {
                sectionModels.append(
                    ForecastSectionViewModel(
                        headerModel: ForecastHeaderModel(title: weekday),
                        cellModels: [ForecastCellModel(forecast: forecast)]
                    )
                )
            }
        }
    }
}

final class ForecastSectionViewModel {
    var headerModel: ForecastHeaderModel
    lazy var cellModels = [ForecastCellModel]()
    
    init(
        headerModel: ForecastHeaderModel,
        cellModels: [ForecastCellModel]
    ) {
        self.headerModel = headerModel
        self.cellModels = cellModels
    }
}
