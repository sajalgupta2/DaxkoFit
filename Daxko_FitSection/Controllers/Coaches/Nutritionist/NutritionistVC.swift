//
//  NutritionistVC.swift
//  Daxko_FitSection
//
//  Created by Anurag Kashyap on 10/11/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit

import UIKit

let nutritionistStroryBoardName = "Nutritinoist"
let nutritionistVC = "NutritionistVC"

class NutritionistVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var postArray = ["Anurag", "Sagar", "Shruti", "Asif","Jyotsna","Himanshu"]
    var standardArray = ["Premium", "Advanced", "Premium", "Advanced","Adnavced","Basic"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

//MARK: Delegate
extension NutritionistVC : UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
           let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
           let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
           return CGSize(width: size, height: size)
       }
}


//MARK: Datasource
extension NutritionistVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NutrinoistCollectionViewCell", for: indexPath) as! NutrinoistCollectionViewCell
        cell.titleLabel.text = postArray[indexPath.row]
        cell.standardLabel.text = standardArray[indexPath.row]
        return cell
    }
}


extension NutritionistVC : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
           let vc = UIStoryboard.init(name: nutritionistStroryBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: coachDetailsVC) as? CoachDetailsVC
                 self.navigationController?.pushViewController(vc!, animated: true)
    }
}
