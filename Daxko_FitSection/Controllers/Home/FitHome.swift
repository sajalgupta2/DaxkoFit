//
//  ViewController.swift
//  Daxko_FitSection
//
//  Created by Anurag Kashyap on 07/11/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit
import JJFloatingActionButton

class FitHome: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var actionButton: JJFloatingActionButton!
    
    var postArray = ["Measurements", "Transformation", "Daxko Fit Shop", "Meals", "Daxko Events"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFloatingButton()
    }
    
    func setupFloatingButton() {
        
        actionButton.itemAnimationConfiguration = .circularSlideIn(withRadius: 80)
        actionButton.buttonAnimationConfiguration = .rotation(toAngle: .pi * 3 / 4)
        actionButton.buttonAnimationConfiguration.opening.duration = 0.8
        actionButton.buttonAnimationConfiguration.closing.duration = 0.6

        actionButton.addItem(image: #imageLiteral(resourceName: "Trainer")) { item in
            self.pushNavigationController(storyBoardName: trainerStroryBoardName, viewControllerIdentifier: trainerVC, caseValue: 4)
        }

        actionButton.addItem(image: #imageLiteral(resourceName: "Nut")) { item in
            self.pushNavigationController(storyBoardName: nutritionistStroryBoardName, viewControllerIdentifier: nutritionistVC, caseValue: 5)
        }
        
        actionButton.display(inViewController: self)
    }
}

//MARK: Delegate
extension FitHome : UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
           let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
           let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
           return CGSize(width: size, height: size)
       }
}


//MARK: Datasource
extension FitHome : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FitHomeCollectionViewCell", for: indexPath) as! FitHomeCollectionViewCell
        cell.titleLabel.text = postArray[indexPath.row]
        //cell.imageViewFitCategories.image = UIImage(named: postArray[indexPath.row])
        return cell
    }
}

extension FitHome : UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            pushNavigationController(storyBoardName: measurementStroryBoardName, viewControllerIdentifier: measurementVC, caseValue: 0)
            
        case 1:
            pushNavigationController(storyBoardName: transformationStroryBoardName, viewControllerIdentifier: transformationVC, caseValue: 1)
            
        case 2:
            pushNavigationController(storyBoardName: fitStroryBoardName, viewControllerIdentifier: fitVC, caseValue: 2)
        case 3:
            pushNavigationController(storyBoardName: recipiesStroryBoardName, viewControllerIdentifier: recipiesVC, caseValue: 3)
            
        default:
            pushNavigationController(storyBoardName: eventsStroryBoardName, viewControllerIdentifier: eventsListVC, caseValue: 6)
        }
    }
}

extension FitHome {
    
    func pushNavigationController(storyBoardName : String, viewControllerIdentifier: String, caseValue : Int) {
        
        switch caseValue {
        case 0:
            let vc = UIStoryboard.init(name: storyBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: viewControllerIdentifier) as? MeasurementsVC
            self.navigationController?.pushViewController(vc!, animated: true)
            
        case 1:
            let vc = UIStoryboard.init(name: storyBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: viewControllerIdentifier) as? TransformationVC
            self.navigationController?.pushViewController(vc!, animated: true)
            
        case 2:
            let vc = UIStoryboard.init(name: storyBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: viewControllerIdentifier) as? FitShopVC
            self.navigationController?.pushViewController(vc!, animated: true)
            
        case 3:
            let vc = UIStoryboard.init(name: storyBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: viewControllerIdentifier) as? RecipiesVC
            self.navigationController?.pushViewController(vc!, animated: true)
            
        case 4:
            let vc = UIStoryboard.init(name: storyBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: viewControllerIdentifier) as? TrainerVC
                   self.navigationController?.pushViewController(vc!, animated: true)
          case 5:
            let vc = UIStoryboard.init(name: storyBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: viewControllerIdentifier) as? NutritionistVC
                   self.navigationController?.pushViewController(vc!, animated: true)
        default:
            let vc = UIStoryboard.init(name: storyBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: viewControllerIdentifier) as? EventsListVC
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
}
