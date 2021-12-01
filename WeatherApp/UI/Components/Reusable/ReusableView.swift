//
//  ReusableView.swift
//  WeatherApp
//
//  Created by Aleksandre Pertaia on 30.11.21.
//

import UIKit

class ReusableView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    convenience init() {
        self.init(frame: CGRect.zero)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: className, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
