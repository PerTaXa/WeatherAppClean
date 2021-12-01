//
//  HasLoader.swift
//  WeatherApp
//
//  Created by Aleksandre Pertaia on 28.11.21.
//

import UIKit

protocol HasLoader: AnyObject {
    var loader: ScreenLoader { get }
    
    func startLoader()
    func stopLoader()
}

extension HasLoader where Self: UIViewController {
    
    func startLoader() {
        loader.start(on: view)
    }
    
    func stopLoader() {
        loader.stop()
    }
}
