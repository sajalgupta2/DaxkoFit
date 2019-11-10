//
//  FitShopVC.swift
//  Daxko_FitSection
//
//  Created by Anurag Kashyap on 08/11/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit

let fitStroryBoardName = "FitShop"
let fitVC = "FitShopVC"

class FitShopVC: UIViewController {

    @IBOutlet weak var shopCollectionView: UICollectionView!
    
    var shopArray = ["T-Shirt", "Cycle", "Apple Air pods", "Sony BDV", "American Touristor", "Samsung Tab", "Apple iPad", "Rayban", "Cannon EOS", "Go Pro", "Seagate", "WD Hard disk", "Macbook"]
    
    var priceArray = ["$100","$600","$700","$1500","$1700","$800","$400","$900","$100","$200","$500","$890","$750"]
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

//MARK: Delegate
extension FitShopVC : UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
           let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
           let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
           return CGSize(width: size, height: size)
       }
}


//MARK: Datasource
extension FitShopVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCollectionViewCell", for: indexPath) as! ShopCollectionViewCell
        cell.itemName.text = shopArray[indexPath.row]
        cell.priceLabel.text = priceArray[indexPath.row]
        return cell
    }
}

extension FitShopVC : UICollectionViewDelegate {
    
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
          let vc = UIStoryboard.init(name: fitStroryBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: fitProductDetailsVC) as? FitProductDetailsVC
          self.navigationController?.pushViewController(vc!, animated: true)
        
      }
}
