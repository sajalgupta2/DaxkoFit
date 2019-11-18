//
//  ShopCollectionViewCell.swift
//  Daxko_FitSection
//
//  Created by Anurag Kashyap on 08/11/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit

class ShopCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var bottomContainerView: GradientView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var layoutState: LayoutState?
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shopImageView.backgroundColor = UIColor.gray
        setgradient()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
      
    
        bgView.drawShadow(shadowColor: UIColor.red, offset: CGSize.zero, radius: 4)
        bgView.setCorner(cornerRadius: 5, clip: true)
       
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
      
        //image height = 114
         //image weight
        
        
//        if let layoutState = layoutState, layoutState == .list {
//            UIView.animate(withDuration: 0.3) {
//                self.shopImageView.transform = CGAffineTransform(scaleX: 0.7, y: 1)
//
//                self.shopImageView.transform = CGAffineTransform(translationX: -200, y: 1)
//               // self.bottomContainerView.transform = CGAffineTransform(scaleX: 0.7, y: 1)
//                self.bottomContainerView.transform = CGAffineTransform(translationX: 200, y: -self.shopImageView.frame.height)
//                    //  self.bottomContainerView.frame.size.width = self.frame.width - self.shopImageView.frame.width
//                print("self.shopImageView.frame.width ", self.shopImageView.bounds.width/0.7)
//                 print("self.shopImageView.frame.height ", self.shopImageView.bounds.height)
//               // self.shopImageView.contentMode = .scaleToFill
//            }
//
//        } else {
//            // self.shopImageView.contentMode = .scaleAspectFill
//              UIView.animate(withDuration: 0.05) {
//                self.shopImageView.transform = .identity
//                self.bottomContainerView.transform = .identity
//            }
            
       // }
        
    }
    
    private func setgradient() {
        bottomContainerView.secondColor = UIColor.black.withAlphaComponent(0.5)
        bottomContainerView.firstColor = UIColor.cyanTheme
        bottomContainerView.gradientLocation = 0.5
    }
    
}
