//
//  Utils.swift
//  WeatherApp
//
//  Created by Aleksandre Pertaia on 28.11.21.
//

import UIKit

func instantiate<T: UIViewController>(_ viewController: T.Type, from storyboard: String) -> T {
    let storyboard = UIStoryboard(name: storyboard, bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: viewController.className) as! T
    
}
