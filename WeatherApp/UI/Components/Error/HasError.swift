//
//  HasError.swift
//  WeatherApp
//
//  Created by Aleksandre Pertaia on 30.11.21.
//

import UIKit

protocol HasError: AnyObject {
    var error: ErrorView { get }
    
    func showError(error message: String)
    func dismissError()
    func updateErrorConstraints()
}

extension HasError where Self: UIViewController {
    
    func showError(error message: String = Constants.Error.generalError) {
        error.start(on: view, error: message, UIDevice.current.orientation)
    }
    
    func dismissError() {
        error.stop()
    }
    
    func updateErrorConstraints() {
        error.updateContraints(on: view, UIDevice.current.orientation)
    }
}
