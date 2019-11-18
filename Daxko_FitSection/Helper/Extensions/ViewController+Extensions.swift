//
//  ViewController+Extensions.swift
//  Daxko_FitSection
//
//  Created by Anurag Kashyap on 08/11/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit

extension UIViewController  {

    /// Open action sheet for filter the items
    /// - Parameters:
    ///   - title: Title of the sheet
    ///   - message: Description
    ///   - alphabetical: sort list  A-Z
    ///   - price: sort list  as per the price
     func filterActioSheet(title: String? = nil, message: String? = nil, alphabetical: @escaping (() -> Void), price: @escaping (() -> Void)) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
           
            alert.addAction(UIAlertAction(title: "Sort by Alphabetically", style: .default, handler: { action in
                alphabetical()
            }))
          
            alert.addAction(UIAlertAction(title: "Sort by Price", style: .default, handler: { action in
                price()
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                
            }))
                self.present(alert, animated: true, completion: nil)
        }

}



extension UIView {
    
    func setCardView() {
        layer.cornerRadius = 5.0
        layer.borderColor  =  UIColor.black.cgColor
        layer.borderWidth = 0.5
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 0.5
        layer.shadowOffset = CGSize(width:0.2, height: 0.2)
        layer.masksToBounds = true
        
    }
    func setCorner(cornerRadius: CGFloat, clip:Bool) {
        
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = clip
    }
    
    func setBorder(color: UIColor, width: CGFloat , cornerRadius: CGFloat){
        
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    
    func drawShadow(shadowColor: UIColor = UIColor.black, opacity: Float = 0.5, offset: CGSize, radius: CGFloat , shouldRasterize : Bool = false) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false
        self.layer.shouldRasterize = shouldRasterize
    }
}
