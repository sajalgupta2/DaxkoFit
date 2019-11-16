//
//  GradientView.swift
//  
//
//  Created by Sajal on 09/07/18.
//  Copyright © 2018 Sajal Gupta. All rights reserved.
//


import UIKit

@IBDesignable
class GradientView: UIView {
    
    @IBInspectable var firstColor: UIColor = UIColor.black {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var secondColor: UIColor = UIColor.cyanTheme {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var gradientLocation: Float = 0.6 { // set value between 0 to 1
        didSet {
            updateView()
        }
    }
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [firstColor.cgColor, secondColor.cgColor]
        layer.locations = [NSNumber(value:gradientLocation)]
    }
}
