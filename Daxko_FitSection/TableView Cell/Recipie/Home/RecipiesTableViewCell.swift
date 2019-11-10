//
//  RecipiesTableViewCell.swift
//  Daxko_FitSection
//
//  Created by Anurag Kashyap on 08/11/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit

class RecipiesTableViewCell: UITableViewCell {

    @IBOutlet weak var recipieCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.recipieCollectionView.delegate = self
        self.recipieCollectionView.dataSource = self
    }
}

extension RecipiesTableViewCell : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = recipieCollectionView.dequeueReusableCell(withReuseIdentifier: "MoreRecipiesCollectionViewCell", for: indexPath) as! MoreRecipiesCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Section: \(indexPath.section)")
        print("Row: \(indexPath.row)")
    }  
}
