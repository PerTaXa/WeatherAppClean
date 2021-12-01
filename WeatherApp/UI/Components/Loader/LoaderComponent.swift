//
//  LoaderComponent.swift
//  WeatherApp
//
//  Created by Aleksandre Pertaia on 28.11.21.
//

import UIKit

final class ScreenLoader {
    
    private var containerView = UIView()
    private var isLoading = false
    
    private let visualEffectsView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let effectView = UIVisualEffectView(effect: blurEffect)
        return effectView
    }()
    
    func start(on view: UIView) {
        guard isLoading == false else { return }
        isLoading = true
        setup(on: view)
        view.addSubview(containerView)
    }
    
    func stop() {
        guard isLoading else { return }
        isLoading = false
        containerView.removeFromSuperview()
    }
    
    func setup(on view: UIView) {
        containerView.frame = view.frame
        containerView.addSubview(self.visualEffectsView)
        visualEffectsView.fillToParent()
        
        let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        spinner.color = .darkGray
        
        containerView.addSubview(spinner)
        spinner.center = containerView.center
        spinner.startAnimating()
    }
}
