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
    
    

    lazy var fitShopDetails = [
        FitShopDetails(shopName: "American", price: 1700),
        FitShopDetails(shopName: "Apple Air pods", price: 700),
        FitShopDetails(shopName: "Apple iPad", price: 1500),
        FitShopDetails(shopName: "Cannon EOS", price: 100),
        FitShopDetails(shopName: "Cycle", price: 600),
        FitShopDetails(shopName: "Go Pro", price: 200),
        FitShopDetails(shopName: "Macbook", price: 750),
        FitShopDetails(shopName: "Rayban", price: 900),
        FitShopDetails(shopName: "Samsung Tab", price: 700),
        FitShopDetails(shopName: "Seagate", price: 500),
        FitShopDetails(shopName: "Sony BDV", price: 1500),
        FitShopDetails(shopName: "T-Shirt", price: 100),
        FitShopDetails(shopName: "Touristor", price: 800),
        FitShopDetails(shopName: "WD Hard disk", price: 890),
    ]
  
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
         
    }
    
//    let gridLayoutStaticCellHeight = 200
//    let listLayoutStaticCellHeight = 120
//    private lazy var listLayout = BaseLayout(staticCellHeight: CGFloat(listLayoutStaticCellHeight), nextLayoutStaticCellHeight: gridLayoutStaticCellHeight, layoutState: .listLayoutState)
//
//    private lazy var gridLayout = BaseLayout(staticCellHeight: CGFloat(gridLayoutStaticCellHeight), nextLayoutStaticCellHeight: listLayoutStaticCellHeight, layoutState: .gridLayoutState)
//
//    private var layoutState: CollectionViewLayoutState = .listLayoutState
    enum SortBy: Int {
        case alphabetically = 0
        case piceLowToHigh = 1
        
        init(value: Int) {
            self = SortBy(rawValue: value) ?? .alphabetically
        }
        
        var ids: [Int] {
            return [SortBy.alphabetically.rawValue, SortBy.piceLowToHigh.rawValue]
        }
        
        var options: [String] {
             return [SortBy.alphabetically.formattedText, SortBy.piceLowToHigh.formattedText]
        }
        var formattedText: String {
            switch self {
            case .alphabetically:
                return "A-Z"
            case .piceLowToHigh:
                return "Price - Low To High"
            }
        }
    }
    
    enum FitShopCollectionType {
        case listView
        case gridView
    }
    

    var collectionType = FitShopCollectionType.gridView
    var selectedSortBy = SortBy.alphabetically {
        didSet {
            dropDownTextFld.text = selectedSortBy.formattedText
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
                            
      // setupSortedFilter()
        registerXib()
        setData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    
    func registerXib() {
        shopCollectionView.register(UINib(nibName: FitShopListCell.defaultReuseIdentifier, bundle: nil), forCellWithReuseIdentifier: FitShopListCell.defaultReuseIdentifier)
    }
    func setupSortedFilter(type: SortBy = .alphabetically) {
        // set default text
        selectedSortBy = type
        
        switch selectedSortBy {
        case .alphabetically:
            fitShopDetails = fitShopDetails.sorted(by: { (object1, object2) -> Bool in
                return object1.shopName < object2.shopName
            })
        case .piceLowToHigh:
            fitShopDetails = fitShopDetails.sorted(by: { (object1, object2) -> Bool in
                return object1.price < object2.price
            })
        }
         shopCollectionView.reloadSections(IndexSet(integer: 0))
    }
    
    func setData() {
      
        dropDownTextFld.optionIds = selectedSortBy.ids
        dropDownTextFld.optionArray = selectedSortBy.options
        dropDownTextFld.selectedIndex = selectedSortBy.rawValue
        dropDownTextFld.text = selectedSortBy.formattedText
//       dropDownTextFld.arrowSize = self.dropDownTextFld.bounds
               dropDownTextFld.delegate = self

        dropDownTextFld.didSelect { (selectedText, index, id) in
            let type = SortBy(value: index)
            self.selectedSortBy = type
            self.setupSortedFilter(type: type)
        }
               
    }
    
    
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

    
    @IBAction func listGridToggleBtn(_ sender: UIButton) {
        if collectionType == .listView {
            collectionType = .gridView
        } else {
            collectionType = .listView
        }
        
//        let transitionManager: TransitionManager
//              if layoutState == .listLayoutState {
//                  layoutState = .gridLayoutState
//                  transitionManager = TransitionManager(duration: animationDuration, collectionView: collectionView!, destinationLayout: gridLayout, layoutState: layoutState)
//              } else {
//                  layoutState = .ListLayoutState
//                  transitionManager = TransitionManager(duration: animationDuration, collectionView: collectionView!, destinationLayout: listLayout, layoutState: layoutState)
//              }
//              transitionManager.startInteractiveTransition()
//
//
//        shopCollectionView.collectionViewLayout.invalidateLayout()
        shopCollectionView.reloadData()
      //  shopCollectionView.reloadSections(IndexSet(integer: 0))
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
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationItem.title = "Daxko Fit Shop"
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationItem.title = "Back"
//    }
    
    @IBAction func cartBarButtonAction(_ sender: UIBarButtonItem) {
       let vc = UIStoryboard.init(name: fitStroryBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: myCartVC) as? MyCartVC
       self.navigationController?.pushViewController(vc!, animated: true)
    }
}

//MARK: CollectionView Delegate DataSource
//==========================================
extension FitShopVC: UICollectionViewDataSource, UICollectionViewDelegate,  UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
          if collectionType == .gridView {
           let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
           let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
           let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
           return CGSize(width: size, height: size)
          } else {
            return CGSize(width: self.shopCollectionView.frame.width, height: 130)
        }
       }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return fitShopDetails.count
     }
    
//    func collectionView(_ collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout {
//         let customTransitionLayout = TransitionLayout(currentLayout: fromLayout, nextLayout: toLayout)
//              return customTransitionLayout
//    }
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionType == .gridView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCollectionViewCell", for: indexPath) as! ShopCollectionViewCell
            cell.itemName.text = fitShopDetails[indexPath.row].shopName
            cell.priceLabel.text = fitShopDetails[indexPath.row].formattedPrice
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FitShopListCell.defaultReuseIdentifier, for: indexPath) as! FitShopListCell
            
             return cell
            
        }
         
     }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          
            let vc = UIStoryboard.init(name: fitStroryBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: fitProductDetailsVC) as? FitProductDetailsVC
            self.navigationController?.pushViewController(vc!, animated: true)
          
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionType == .gridView {
            return 10
        } else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionType == .gridView {
            return 10
        } else {
            return 0
        }
        
    }
}



extension FitShopVC: UITextFieldDelegate  {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
           return false
       }
    
}
