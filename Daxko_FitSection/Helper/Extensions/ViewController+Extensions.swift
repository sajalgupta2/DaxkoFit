//
//  ViewController+Extensions.swift
//  Daxko_FitSection
//
//  Created by Anurag Kashyap on 08/11/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

func setCardView(){
    layer.cornerRadius = 5.0
    layer.borderColor  =  UIColor.black.cgColor
    layer.borderWidth = 0.5
    layer.shadowOpacity = 0.5
    layer.shadowRadius = 0.5
    layer.shadowOffset = CGSize(width:0.2, height: 0.2)
    layer.masksToBounds = true
    
    }
}
