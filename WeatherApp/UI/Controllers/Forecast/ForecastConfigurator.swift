//
//  ForecastConfigurator.swift
//  WeatherApp
//
//  Created by Aleksandre Pertaia on 29.11.21.
//

import UIKit

final class ForecastConfigurator {
    
    static var instance: UIViewController {
        let controller = instantiate(ForecastController.self, from: Constants.Storyboard.main)
        let presenter = ForecastPresenter(controller: controller)
        let interactor = ForecastInteractor(presenter: presenter)
        
        controller.interactor = interactor
        controller.tabBarItem = UITabBarItem(
            title: Constants.Tab.Forecast.title,
            image: Constants.Tab.Forecast.image,
            tag: 0
        )
        return UINavigationController(rootViewController: controller)
    }
}
