//
//  RecipiesVC.swift
//  Daxko_FitSection
//
//  Created by Anurag Kashyap on 08/11/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit

let recipiesStroryBoardName = "Recipies"
let recipiesVC = "RecipiesVC"

class RecipiesVC: Recipies_Extensions {

    @IBOutlet weak var headerCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var headerFoodArray = ["Indian","Chiniese","Continetal","Veg","Non Veg", "By You"]
    
    var sectionTitle = ["Breakfast","Lunch","Snacks","Dinner"]
    
    lazy var menuLauncher: SelectionMenuLauncher = {
           let launcher = SelectionMenuLauncher()
           return launcher
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func createRecipieAction(_ sender: UIBarButtonItem) {
        
        let categories = ["Add Recipie"]
        menuLauncher.launch(dataArray: categories) { (indexValue) in
            if indexValue > -1 {
                switch indexValue {
                case 0:
                    self.pushNavigationController(storyBoardName: recipiesStroryBoardName, viewControllerIdentifier: addRecipieVC, caseValue: 0)
                default:
                    break
                }
            }
        }
    }
}

//MARK: Delegate
extension RecipiesVC : UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
           let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
           let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
           return CGSize(width: size, height: size)
       }
}


//MARK: Datasource
extension RecipiesVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headerFoodArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipiesHeaderCollectionViewCell", for: indexPath) as! RecipiesHeaderCollectionViewCell
        cell.headerFoodNameLabel.text = headerFoodArray[indexPath.row]
        return cell
    }
    
}

extension RecipiesVC : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.pushNavigationController(storyBoardName: recipiesStroryBoardName, viewControllerIdentifier: recipiesListVC, caseValue: 1)
    }
}

extension RecipiesVC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipiesTableViewCell", for: indexPath) as! RecipiesTableViewCell
        return cell
    }
}

extension RecipiesVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
      }
    
}

