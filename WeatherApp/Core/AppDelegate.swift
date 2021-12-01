//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Aleksandre Pertaia on 28.11.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    @available(iOS 12.0, *)
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 12.0, *) {
            window = UIWindow(frame: UIScreen.main.bounds)
            let mainTabBar = instantiate(UITabBarController.self, from: Constants.Storyboard.main)
            mainTabBar.viewControllers = [
                TodayConfigurator.instance,
                ForecastConfigurator.instance
            ]
            window?.rootViewController = mainTabBar
            window?.makeKeyAndVisible()
        }
        return true
    }

    // MARK: UISceneSession Lifecycle


    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

