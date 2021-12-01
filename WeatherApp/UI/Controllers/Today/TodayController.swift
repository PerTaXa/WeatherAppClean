//
//  TodayController.swift
//  WeatherApp
//
//  Created by Aleksandre Pertaia on 28.11.21.
//

import UIKit
import SDWebImage

typealias TodayDisplaying = TodayViewProtocol & HasLoader & HasError

protocol TodayViewProtocol: UIViewController {
    var interactor: TodayInteracting! { get set }
    func configure(with viewModel: TodayViewModel)
    func showErrorView(with message: String)
}

final class TodayController: LoaderErrorController, TodayViewProtocol {
    var interactor: TodayInteracting!

    @IBOutlet var weatherStack: UIStackView!
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var detailsStack: UIStackView!
    @IBOutlet var cloudnessImage: UIImageView!
    @IBOutlet var cloudnessLabel: UILabel!
    @IBOutlet var humidityImage: UIImageView!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var celsiusImage: UIImageView!
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var windImage: UIImageView!
    @IBOutlet var windLabel: UILabel!
    @IBOutlet var directionImage: UIImageView!
    @IBOutlet var directionLabel: UILabel!
    @IBOutlet var threeItemStack: UIStackView!
    @IBOutlet var twoItemStack: UIStackView!
    @IBOutlet var windStack: UIStackView!
    @IBOutlet var directionStack: UIStackView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.loadWeatherData()
        applyTheme()
        error.delegate = self
        setupInfoStacks()
    }
    
    func configure(with viewModel: TodayViewModel) {
        stopLoader()
        dismissError()
        weatherImage.sd_setImage(with: URL(string: viewModel.iconURL)!, completed: nil)
        locationLabel.text = viewModel.place
        weatherLabel.text = viewModel.todayWeather
        cloudnessLabel.text = viewModel.cloudiness
        humidityLabel.text = viewModel.humidity
        celsiusLabel.text = viewModel.pressure
        windLabel.text = viewModel.windSpeed
        directionLabel.text = viewModel.windDirection
    }

    @IBAction func handleShare(_ sender: UIButton) {
        let activity = UIActivityViewController(
            activityItems: ["\(locationLabel.text!), \(weatherLabel.text!)"],
            applicationActivities: nil
        )
        present(activity, animated: true, completion: nil)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        updateErrorConstraints()
        setupInfoStacks()
    }

    @objc private func refresh() {
        dismissError()
        interactor.loadWeatherData()
    }
    
    private func applyTheme() {
        weatherImage.tintColor = Constants.Color.accent
        cloudnessImage.tintColor = Constants.Color.accent
        humidityImage.tintColor = Constants.Color.accent
        celsiusImage.tintColor = Constants.Color.accent
        windImage.tintColor = Constants.Color.accent
        directionImage.tintColor = Constants.Color.accent
    }
    
    private func setupInfoStacks() {
        switch UIDevice.current.orientation{
        case .landscapeLeft, .landscapeRight:
            twoItemStack.isHidden = true
            threeItemStack.addArrangedSubview(windStack)
            threeItemStack.addArrangedSubview(directionStack)
        default:
            twoItemStack.isHidden = false
            twoItemStack.addArrangedSubview(windStack)
            twoItemStack.addArrangedSubview(directionStack)
        }
        
    }

}

extension TodayController: ErrorViewDelegate {

    func errorView(_ sender: ErrorView, didClickButton: UIButton) {
        refresh()
    }

    func showErrorView(with message: String) {
        stopLoader()
        showError(error: message)
    }
}

