//
//  ErrorComponent.swift
//  WeatherApp
//
//  Created by Aleksandre Pertaia on 30.11.21.
//

import UIKit

protocol ErrorViewDelegate: AnyObject {
    func errorView(_ sender: ErrorView, didClickButton: UIButton)
}

final class ErrorView {
    
    private var containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private var viewingError = false
    weak var delegate: ErrorViewDelegate?
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView, title, refresh])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    lazy var imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(named: "data_load_error")
        return imgView
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = label.font.withSize(15.0)
        return label
    }()
    
    lazy var refresh: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .orange
        button.setTitle("Refresh", for: .normal)
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        return button
    }()
    
    private var stackConstraintPortrait: NSLayoutConstraint!
    private var stackConstraintLandscape: NSLayoutConstraint!
    
    
    func start(on view: UIView, error message: String, _ orientation: UIDeviceOrientation) {
        guard viewingError == false else { return }
        viewingError = true
        view.addSubview(containerView)
        view.bringSubviewToFront(containerView)
        containerView.fillToParent()
        setup(on: view, orientation)
        
        title.text = message
    }
    
    func stop() {
        guard viewingError else { return }
        viewingError = false
        containerView.removeFromSuperview()
    }
    
    func setup(on view: UIView, _ orientation: UIDeviceOrientation) {
        containerView.frame = view.frame
        containerView.addSubview(self.stack)
        stack.centerToParent()
        stackConstraintPortrait = stack.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5)
        stackConstraintLandscape = stack.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.2)
        
        updateContraints(on: view, orientation)
        
        imageView.heightAnchor.constraint(equalTo: stack.widthAnchor).isActive = true
        
    }
    
    func updateContraints(on view: UIView, _ orientation: UIDeviceOrientation) {
        guard viewingError else { return }
        let isLandscape = orientation == .landscapeLeft || orientation == .landscapeRight
        if isLandscape {
            stackConstraintPortrait.isActive = !isLandscape
            stackConstraintLandscape.isActive = isLandscape
        } else {
            stackConstraintLandscape.isActive = isLandscape
            stackConstraintPortrait.isActive = !isLandscape
        }
        
        view.layoutIfNeeded()
    }
    
    @objc func buttonClicked(sender: UIButton){
        delegate?.errorView(self, didClickButton: sender)
    }
}
