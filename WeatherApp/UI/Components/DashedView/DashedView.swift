//
//  DashedView.swift
//  WeatherApp
//
//  Created by Aleksandre Pertaia on 30.11.21.
//

import UIKit

class DashedView: ReusableView {


    @IBInspectable var dashColor: UIColor = UIColor.darkGray
    
    lazy var shape: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 2
        shapeLayer.lineDashPattern = [4, 2]
        return shapeLayer
    }()
    
    override func commonInit() {
        super.commonInit()
        contentView.layer.addSublayer(shape)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: 0), CGPoint(x: bounds.width, y: 0)])
        shape.path = path
        shape.strokeColor = dashColor.cgColor
    }
}
