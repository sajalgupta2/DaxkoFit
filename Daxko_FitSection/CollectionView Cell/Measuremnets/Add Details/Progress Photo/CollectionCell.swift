//
//  CollectionCell.swift
//  GlidingCollection
//
//  Created by Abdurahim Jauzee on 07/03/2017.
//  Copyright © 2017 Ramotion Inc. All rights reserved.
//

import UIKit
import GlidingCollection

class CollectionCell: UICollectionViewCell {
  
  @IBOutlet var imageView: UIImageView!
    
    func configureCell(collectionCell: UICollectionViewCell) {
          let layer = collectionCell.layer
          let config = GlidingConfig.shared
          layer.shadowOffset = config.cardShadowOffset
          layer.shadowColor = config.cardShadowColor.cgColor
          layer.shadowOpacity = config.cardShadowOpacity
          layer.shadowRadius = config.cardShadowRadius
          layer.shouldRasterize = true
          layer.rasterizationScale = UIScreen.main.scale
      }
    
}
