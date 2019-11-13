//
//  RecipieListVC.swift
//  Daxko_FitSection
//
//  Created by Anurag Kashyap on 08/11/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit

let recipiesListVC = "RecipieListVC"

class RecipieListVC: UIViewController {

    var recipieListArray = ["Cake", "Bread", "Egg", "Chicken", "Fish"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Recipie List"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = "Back"
    }
    
    
    @IBAction func myCartBarButtonAction(_ sender: UIBarButtonItem) {
        let vc = UIStoryboard.init(name: fitStroryBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: myCartVC) as? MyCartVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

//MARK: Delegate
extension RecipieListVC : UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
           let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
           let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
           return CGSize(width: size, height: size)
       }
}


//MARK: Datasource
extension RecipieListVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipieListArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipieListCollectionViewCell", for: indexPath) as! RecipieListCollectionViewCell
        cell.titleLabel.text = recipieListArray[indexPath.row]
        //cell.imageViewFitCategories.image = UIImage(named: postArray[indexPath.row])
        return cell
    }
}

extension RecipieListVC : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pushNavigationController(storyBoardName: recipiesStroryBoardName, viewControllerIdentifier: recipiesInfoVC, caseValue: 0)
    }
}

extension RecipieListVC {
    
    func pushNavigationController(storyBoardName : String, viewControllerIdentifier: String, caseValue : Int) {
        
        switch caseValue {
        case 0:
            
           if let vc = UIStoryboard.init(name: storyBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: viewControllerIdentifier) as? RecipielnfoVC{
                self.present(vc, animated: true, completion: nil)
            }
            
        default:
            if let vc = UIStoryboard.init(name: storyBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: viewControllerIdentifier) as? RecipielnfoVC{
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
}
