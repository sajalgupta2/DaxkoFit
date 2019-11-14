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

    @IBOutlet weak var dropDownTextFld: DropDown!
    @IBOutlet weak var shopCollectionView: UICollectionView!
    @IBOutlet weak var filterOptionView: UIView!
    
    
<<<<<<< HEAD
    lazy var fitShopDetails = [FitShopDetails(shopName: "T-Shirt", price: 100), FitShopDetails(shopName: "Cycle", price: 600),
                               FitShopDetails(shopName: "Apple Air pods", price: 700),
                               FitShopDetails(shopName: "Sony BDV", price: 1500),
                               FitShopDetails(shopName: "American", price: 1700),
                               FitShopDetails(shopName: "Touristor", price: 800),
                               FitShopDetails(shopName: "Samsung Tab", price: 700),
                               FitShopDetails(shopName: "Apple iPad", price: 1500),
                               FitShopDetails(shopName: "Rayban", price: 900),
                               FitShopDetails(shopName: "Cannon EOS", price: 100),
                               FitShopDetails(shopName: "Go Pro", price: 200),
                               FitShopDetails(shopName: "Seagate", price: 500),
                               FitShopDetails(shopName: "WD Hard disk", price: 890),
                               FitShopDetails(shopName: "Macbook", price: 750)
    ]
=======
    var priceArray = ["$100","$600","$700","$1500","$1700","$800","$400","$900","$100","$200","$500","$890","$750"]
>>>>>>> 110216b270cfb24f23026c5ead28cb89edf8aae4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    func setupNavigationBar() {
       
         //setRightBarButton()
    }
    
    
    func setData() {
        //Its Id Values and its optional
        dropDownTextFld.optionIds = [1,23,54,22]

        // Image Array its optional
        dropDownTextFld.optionArray = ["Option 1", "Option 2", "Option 3"]

     //   dropDownTextFld.ImageArray = [👩🏻‍🦳, 🙊,🥞]
        // The the Closure returns Selected Index and String
       // dropDownTextFld.didSelect{(selectedText , index ,id) in
       // self.valueLabel.text = "Selected String: \(selectedText) \n index: \(index)"
    //}
    }
    
<<<<<<< HEAD
    
    func setRightBarButton(with image: UIImage? = UIImage(named: "sharp_filter_list_black_48pt_1x"), text: String? = nil) {

        let filterImage    = UIImage(named: "sharp_filter_list_black_48pt_1x")!
        let gridListImage  = UIImage(named: "sharp_filter_list_black_48pt_1x")!

        let filterBtn   = UIBarButtonItem(image: filterImage,  style: .plain, target: self, action: #selector(filterBarButtonTapped(_:)))
        let toggleBtn = UIBarButtonItem(image: gridListImage,  style: .plain, target: self, action: #selector(toggleGridListView))

        navigationItem.rightBarButtonItems = [filterBtn, toggleBtn]
        
//          if let image = image {
//              navigationItem.rightBarButtonItem  = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(rightBarButtonTapped(_:)))
//          }
//
//        if let image = image {
//            navigationItem.rightBarButtonItem  = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(rightBarButtonTapped(_:)))
//        }
//
//          if let text = text {
//              navigationItem.rightBarButtonItem = UIBarButtonItem(title: text, style: .plain, target: self, action: #selector(rightBarButtonTapped(_:)))
//          }


      }

    @objc private func filterBarButtonTapped(_ sender : UIBarButtonItem) {
        
        filterActioSheet(title: "Filter", alphabetical: {
            self.fitShopDetails = self.fitShopDetails.sorted(by: { $0.shopName < $1.shopName })
            self.shopCollectionView.reloadSections(IndexSet(integer: 0))

        
        }) {
             self.fitShopDetails = self.fitShopDetails.sorted(by: { $0.price < $1.price })
            self.shopCollectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
    @objc private func toggleGridListView(_ sender : UIBarButtonItem) {
          print("toggleGridListView")
         
      }
=======
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Daxko Fit Shop"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = "Back"
    }
    
    @IBAction func cartBarButtonAction(_ sender: UIBarButtonItem) {
       let vc = UIStoryboard.init(name: fitStroryBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: myCartVC) as? MyCartVC
       self.navigationController?.pushViewController(vc!, animated: true)
    }
>>>>>>> 110216b270cfb24f23026c5ead28cb89edf8aae4
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
        return fitShopDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCollectionViewCell", for: indexPath) as! ShopCollectionViewCell
        cell.itemName.text = fitShopDetails[indexPath.row].shopName
        cell.priceLabel.text = fitShopDetails[indexPath.row].formattedPrice
        return cell
    }
}

extension FitShopVC : UICollectionViewDelegate {
    
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
          let vc = UIStoryboard.init(name: fitStroryBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: fitProductDetailsVC) as? FitProductDetailsVC
          self.navigationController?.pushViewController(vc!, animated: true)
        
      }
}
