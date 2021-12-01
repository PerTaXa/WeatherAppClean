//
//  Extensions.swift
//  WeatherApp
//
//  Created by Aleksandre Pertaia on 28.11.21.
//
import UIKit

extension NSObject {
    
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}

extension UIView {
    
    func removeAllSubviews() {
        for sub in self.subviews {
            sub.removeFromSuperview()
        }
    }
    
    func fillToParent() {
        guard let superview = superview else { return }
        fill(superview)
    }
    
    func centerToParent(){
        guard let superview = superview else { return }
        center(superview)
    }
    
    func fill(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func center(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {

            layer.shadowRadius = newValue
        }
    }
    @IBInspectable
    var shadowOffset : CGSize{

        get{
            return layer.shadowOffset
        }set{

            layer.shadowOffset = newValue
        }
    }

    @IBInspectable
    var shadowColor : UIColor{
        get{
            return UIColor.init(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue.cgColor
        }
    }
    @IBInspectable
    var shadowOpacity : Float {

        get{
            return layer.shadowOpacity
        }
        set {

            layer.shadowOpacity = newValue

        }
    }
    
}

extension Double {
    
    func toDate(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = Date(timeIntervalSince1970: self)
        return dateFormatter.string(from: date)
    }
}

extension UITableView {
    
    func registerCell<T>(_ type: T.Type) where T: UITableViewCell {
        register(
            UINib(nibName: type.className, bundle: nil),
            forCellReuseIdentifier: type.className
        )
    }
    
    func registerHeaderFooter<T>(_ type: T.Type) where T: UITableViewHeaderFooterView {
        register(
            UINib(nibName: type.className, bundle: nil),
            forHeaderFooterViewReuseIdentifier: type.className
        )
    }
    
    func dequeueCell<T>(_ type: T.Type, for indexPath: IndexPath) -> T where T: UITableViewCell {
        return dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }
    
    func dequeueHeaderFooter<T>(_ type: T.Type) -> T where T: UITableViewHeaderFooterView {
        return dequeueReusableHeaderFooterView(withIdentifier: type.className) as! T
    }
}
