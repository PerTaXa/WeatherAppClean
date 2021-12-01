//
//  LoaderViewController.swift
//  WeatherApp
//
//  Created by Aleksandre Pertaia on 28.11.21.
//

import UIKit

class LoaderErrorController: UIViewController, HasLoader, HasError {
    let loader = ScreenLoader()
    let error = ErrorView()
}
