//
//  TodayConfigurator.swift
//  WeatherApp
//
//  Created by Aleksandre Pertaia on 28.11.21.
//
import UIKit

final class TodayConfigurator {
    
    static var instance: UIViewController {
        let controller = instantiate(TodayController.self, from: Constants.Storyboard.main)
        let presenter = TodayPresenter(controller: controller)
        let interactor = TodayInteractor(presenter: presenter)
        
        controller.interactor = interactor
        controller.tabBarItem = UITabBarItem(
            title: Constants.Tab.Today.title,
            image: Constants.Tab.Today.image,
            tag: 0
        )
        return UINavigationController(rootViewController: controller)
    }
}

