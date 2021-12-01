//
//  ForecastController.swift
//  WeatherApp
//
//  Created by Aleksandre Pertaia on 29.11.21.
//

import UIKit

typealias ForecastDisplaying = ForecastDrawing & HasLoader & HasError

protocol ForecastDrawing: UIViewController {
    var interactor: ForecastInteracting! { get set }
    func showErrorView(with message: String)
    func configure(with viewModel: ForecastViewModel)
}

final class ForecastController: LoaderErrorController, ForecastDrawing {
    @IBOutlet var tableView: UITableView!

    var interactor: ForecastInteracting!

    var forecast = ForecastViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.loadForecastData()
        registerTableItems()
        error.delegate = self
    }

    func configure(with viewModel: ForecastViewModel) {
        stopLoader()
        dismissError()
        forecast = viewModel
        tableView.reloadData()
    }

    @objc private func refresh() {
        dismissError()
        interactor.loadForecastData()
    }

   

    private func registerTableItems() {
        tableView.registerHeaderFooter(ForecastHeader.self)
        tableView.registerCell(ForecastCell.self)
    }
    
    
}

extension ForecastController: ErrorViewDelegate {

    func errorView(_ sender: ErrorView, didClickButton: UIButton) {
        refresh()
    }

    func showErrorView(with message: String) {
        stopLoader()
        showError(error: message)
    }
}

extension ForecastController: UITableViewDelegate, UITableViewDataSource {
    
    struct Defaults {
        static let headerEstimatedHeight: CGFloat = 36
        static let rowEstimatedHeight: CGFloat = 36
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return forecast.sectionModels.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let model = forecast.sectionModels[section].headerModel
        let header = tableView.dequeueHeaderFooter(ForecastHeader.self)
        header.configure(with: model)
        return header
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return Defaults.headerEstimatedHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecast.sectionModels[section].cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = forecast.sectionModels[indexPath.section].cellModels[indexPath.row]
        let cell = tableView.dequeueCell(ForecastCell.self, for: indexPath)
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return Defaults.rowEstimatedHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
}

