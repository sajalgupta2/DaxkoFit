//
//  FitShopVC.swift
//  Daxko_FitSection
//
//  Created by Anurag Kashyap on 08/11/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//
import UIKit
import SDWebImage

let fitStroryBoardName = "FitShop"
let fitVC = "FitShopVC"

class FitShopVC: UIViewController {
    
    //MARK:- IBOutlets
    //=========================
    @IBOutlet weak var dropDownTextFld: DropDown!
    @IBOutlet weak var shopCollectionView: UICollectionView!
    @IBOutlet weak var filterOptionView: UIView!
    @IBOutlet weak var listGridToggleBtn: UIButton!
    
    //MARK:- Enums
    //=========================
    enum SortBy: Int {
        case alphabetically = 0
        case piceLowToHigh = 1
        case priceHighToLow = 2
        
        init(value: Int) {
            self = SortBy(rawValue: value) ?? .alphabetically
        }
        
        var ids: [Int] {
            return [SortBy.alphabetically.rawValue, SortBy.piceLowToHigh.rawValue, SortBy.priceHighToLow.rawValue]
        }
        
        var options: [String] {
            return [SortBy.alphabetically.formattedText, SortBy.piceLowToHigh.formattedText, SortBy.priceHighToLow.formattedText]
        }
        var formattedText: String {
            switch self {
            case .alphabetically:
                return "A-Z"
            case .piceLowToHigh:
                return "Price - Low To High"
            case .priceHighToLow:
                return "Price - High To Low"
            }
        }
    }
    
    //MARK:- Properties
    //=========================
    private let listLayoutStaticCellHeight: CGFloat = 220 //155.0
    private let gridLayoutStaticCellHeight: CGFloat = 180.0
    
    private lazy var listLayout = DisplaySwitchLayout(staticCellHeight: listLayoutStaticCellHeight, nextLayoutStaticCellHeight: gridLayoutStaticCellHeight, layoutState: .list)
    
    private lazy var gridLayout = DisplaySwitchLayout(staticCellHeight: gridLayoutStaticCellHeight, nextLayoutStaticCellHeight: listLayoutStaticCellHeight, layoutState: .grid)
    
    private lazy var layoutState: LayoutState = AppUserDefaults.getFitShopLayoutStyle(forKey: .fitShopLayoutStyle, fallBackValue: .grid)
    
    private lazy var fitShopDetails = [FitShop]()
    
    var selectedSortBy = SortBy.alphabetically {
        didSet {
            dropDownTextFld.text = selectedSortBy.formattedText
        }
    }
    
    //MARK:- View Life Cycle
    //=========================
    override func viewDidLoad() {
        super.viewDidLoad()
        parseData()
        registerXib()
        setupDropDown()
        setupCollectionLayout()
        shopCollectionView.delegate = self
        shopCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
       // setupNavigationBar()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - Private Methods
    //=====================
   private func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    private func registerXib() {
        shopCollectionView.register(UINib(nibName: FitShopListCell.defaultReuseIdentifier, bundle: nil), forCellWithReuseIdentifier: FitShopListCell.defaultReuseIdentifier)
    }
    private func setupSortedFilter(type: SortBy = .alphabetically) {
        // set default text
        selectedSortBy = type
        
        switch selectedSortBy {
        case .alphabetically:
            fitShopDetails = fitShopDetails.sorted(by: { (object1, object2) -> Bool in
                return object1.name < object2.name
            })
        case .piceLowToHigh:
            fitShopDetails = fitShopDetails.sorted(by: { (object1, object2) -> Bool in
                return object1.price < object2.price
            })
        case .priceHighToLow:
            fitShopDetails = fitShopDetails.sorted(by: { (object1, object2) -> Bool in
                return object1.price > object2.price
            })
        }
        shopCollectionView.reloadSections(IndexSet(integer: 0))
    }
    
    private func setupDropDown() {
        
        dropDownTextFld.optionIds = selectedSortBy.ids
        dropDownTextFld.optionArray = selectedSortBy.options
        dropDownTextFld.selectedIndex = selectedSortBy.rawValue
        dropDownTextFld.text = selectedSortBy.formattedText
        dropDownTextFld.selectedRowColor = UIColor.cyanTheme
        dropDownTextFld.delegate = self
        
        dropDownTextFld.didSelect { (selectedText, index, id) in
            let type = SortBy(value: index)
            self.selectedSortBy = type
            self.setupSortedFilter(type: type)
        }
    }
    
    private func setupCollectionLayout() {
        listGridToggleBtn.setImage(layoutState.icon, for: .normal)
        if layoutState == .grid {
            shopCollectionView.collectionViewLayout = gridLayout
        } else {
            shopCollectionView.collectionViewLayout = listLayout
        }
        
    }
    
    private func parseData() {
     //   guard let url = Bundle.main.url(forResource: "daxko-fit-product", withExtension: "json") else { return }
        
     //   guard let data = try? Data(contentsOf: url) else { return }
        do {
            let decoder = JSONDecoder()
            self.fitShopDetails = try decoder.decode([FitShop].self, from: daxkoFitProduct)
            setupSortedFilter(type: .alphabetically)
        } catch {
            debugPrint(error)
        }
    }
    
    //MARK: - IBAction
    //======================
    @IBAction func listGridToggleBtn(_ sender: UIButton) {
        
        let animationDuration = 0.3
        let transitionManager: TransitionManager
        if layoutState == .list {
            layoutState = .grid
            
            transitionManager = TransitionManager(duration: animationDuration, collectionView: shopCollectionView, destinationLayout: gridLayout, layoutState: layoutState)
        } else {
            layoutState = .list
            transitionManager = TransitionManager(duration: animationDuration, collectionView: shopCollectionView, destinationLayout: listLayout, layoutState: layoutState)
        }
        listGridToggleBtn.setImage(layoutState.icon, for: .normal)
        AppUserDefaults.save(value: layoutState.rawValue, forKey: .fitShopLayoutStyle)
        transitionManager.startInteractiveTransition()
    }
    
    @IBAction func cartBarButtonAction(_ sender: UIBarButtonItem) {
        let vc = UIStoryboard.init(name: fitStroryBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: myCartVC) as? MyCartVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    
}


//MARK: CollectionView Delegate DataSource
//==========================================
extension FitShopVC: UICollectionViewDataSource, UICollectionViewDelegate,  UICollectionViewDelegateFlowLayout {
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //
    //          if collectionType == .gridView {
    //           let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
    //           let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
    //           let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
    //           return CGSize(width: size, height: size)
    //          } else {
    //            return CGSize(width: self.shopCollectionView.frame.width, height: 130)
    //        }
    //       }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fitShopDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout {
        let customTransitionLayout = TransitionLayout(currentLayout: fromLayout, nextLayout: toLayout)
        return customTransitionLayout
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       // if layoutState == .grid {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCollectionViewCell", for: indexPath) as! ShopCollectionViewCell
            cell.itemName.text = fitShopDetails[indexPath.row].name
            cell.priceLabel.text = fitShopDetails[indexPath.row].formattedPrice
            //        cell.bottomContainerView.backgroundColor = UIColor.cyanTheme
            //        cell.shopImageView.image = UIImage(named: "bigstock-chef-decorating-delicious-dess-80769961-1240x698")
        cell.layoutState = self.layoutState
            cell.shopImageView.sd_setImage(with: URL(string: fitShopDetails[indexPath.row].imageUrl), placeholderImage: nil)
            return cell
//        } else {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FitShopListCell.defaultReuseIdentifier, for: indexPath) as! FitShopListCell
//             cell.shopImageView.sd_setImage(with: URL(string: fitShopDetails[indexPath.row].imageUrl), placeholderImage: nil)
//            cell.titleLabel.text = fitShopDetails[indexPath.row].name
//             cell.descriptionLabel.text = fitShopDetails[indexPath.row].formattedPrice
//            return cell
//        }
        
        //        if collectionType == .gridView {
        //
        //            return cell
        //        } else {
                   
        //
        //        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = UIStoryboard.init(name: fitStroryBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: fitProductDetailsVC) as? FitProductDetailsVC
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //        if collectionType == .gridView {
    //            return 10
    //        } else {
    //            return 10
    //        }
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //        if collectionType == .gridView {
    //            return 10
    //        } else {
    //            return 0
    //        }
    //
    //    }
}



extension FitShopVC: UITextFieldDelegate  {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
    
}

//JSON
let daxkoFitProduct = """

[
    {
        "id":1,
        "name":"iShake Steel Shaker Bottle Hot & Cold (Black)",
        "price":"749.00",
        "description":"DOUBLE-WALL VACUUM - Stainless steel insulated protein shaker keeps cold drinks up to 10+ hours cold and keeps hot drinks up to 8 hours warm. LEAKFREE/ SHATTERPROOF - It is proven that a twist-on cap is at least two times more secure than a flip-top cap against spilling and leaking and the lid won’t burst open when dropped. No more accidental leaking/spilling leaving a mess and ruining your day. Our exclusive twist-on cap can be used for hot beverages because the inside air pressure can be released/ ‘gas off’ through the sides of the twist-on cap while opening it slowly whereas flip-top can’t withhold shaking hot drinks. YOU ARE REQUESTED TO TIGHT CAP LITTLE MORE FOR NO LEAKAGE COMPLAINT. ODOR RESISTANT/ EASY TO CLEAN - Our premium stainless steel does not absorb odor and is easy to clean without leaving any stains and it won’t rust. The last thing you want to have is smelly stinking shaker. These reusable stainless steel shaker bottles are great for hiking, biking, the gym, travel, school, work, and just about anywhere you might get thirsty!",
        "product_type":"",
        "image_url":"https://m.media-amazon.com/images/I/71vjeQR+hzL._AC_UL320_ML3_.jpg"
    },
    {
        "id":2,
        "name":"Ketsaal Spider Protein Shaker Bottle 500ml with 2 Storage Extra Compartment for Gym",
        "price":"234.00",
        "description":"Ketsaal brings a very attractive & useful bottle, grab a quick drink and get back to the work.One-handed design makes it easier to grab and hold on the sideline or in the gym leak-proof valve gives you water when you want it, without any mess or waste contoured rubber grip zone offers a place to grip and squeeze for drinking 500ml capacity.",
        "product_type":"",
        "image_url":"https://m.media-amazon.com/images/S/aplus-media/sc/9c92d7a4-59a2-4659-b947-aa322fbec0d4.__CR18,0,462,462_PT0_SX300_V1___.jpg"
    },
    {
        "id":4,
        "name":"XTRIM X Macho Men's Leather Gym Workout Gloves",
        "price":"399.00",
        "description":"Proprietary skin-on-skin [sos] leather that has been used in the gloves will make you feel there is no extra padding in the gloves; it also enhances the grip, protection, feel, and comfort with added durability and strength. Antimicrobial treated mesh and anti-mold washable leather are part of the gloves",
        "product_type":"",
        "image_url":"https://images-eu.ssl-images-amazon.com/images/I/91WUDPZ0w+L._AC._SR360,460.jpg"
    },
    {
        "id":5,
        "name":"Kobo Lifting Gloves with Wrist Support",
        "price":"360.00",
        "description":"Kobo weight lifting gloves is comfortable for lift the heavy weight. It has padded front palm. Weight training gloves with wrist wrap. Wrist wrap stabilizes the wrist joint with adjustable but gentle pressure, keeping the wrist in the proper position while training. Technology ensuring more comfortable wear and easier removal. Perfect air flow performance of the gloves. Fit the natural shape of the hand. Gel padding in the field of palm.",
        "product_type":"",
        "image_url":"https://images-eu.ssl-images-amazon.com/images/I/71yHwTYTf3L._AC._SR360,460.jpg"
    },
    {
        "id":6,
        "name":"Brandvilla Yoga Mat",
        "price":"399.00",
        "description":"Brandvilla is premium fitness gear engineered with principle, performance and progress for the modern human. Our goal at Brandvilla is to bring a meticulous approach to what’s normally referred to as fitness gear. We believe the fitness gear you use should reflect the attention you pay to the most precious asset your body.",
        "product_type":"",
        "image_url":"https://m.media-amazon.com/images/S/aplus-media/vc/4800ea4e-a50c-48be-b201-edd4b8a0594c.__CR0,0,2500,2500_PT0_SX300_V1___.jpg"
    },
    {
        "id":7,
        "name":"AmazonBasics 13mm Extra Thick Yoga and Exercise Mat",
        "price":"999.00",
        "description":"Take your workout to the next level with help from this AmazonBasics 1/2-inch extra-thick yoga and exercise mat. Perfect for home or studio use, the high-quality mat not only defines your personal workout space, but it also creates a beneficial layer of cushioning between you and the floor. Use the mat for anything from yoga or Pilates to stretching, meditation, and other strengthening or restorative floor exercises.",
        "product_type":"",
        "image_url":"https://m.media-amazon.com/images/S/aplus-media/sota/529c7bd4-09d0-445a-9d71-6fb5a8de79db._SR300,300_.jpg"
    },
    {
        "id":8,
        "name":"Hero Kyoto 26T Single Speed Cycle",
        "price":"4,999.00",
        "description":"The cycle is delivered in Semi-Assembled condition (85% assembled). Customer needs to assemble it before use. Allen Key & Spanner provided in box for installation. Tire Size : 26 inches | Frame Size : 18 inches Ideal For : 11+ Years | Min Rider Height : 5 feet | Max Rider Height : 5.8 feet",
        "product_type":"",
        "image_url":"https://m.media-amazon.com/images/I/71CA2d53yML._AC_UY218_ML3_.jpg"
    },
    {
        "id":9,
        "name":"Hero Next 24T 18 Speed Mountain Cycle",
        "price":"7,862.00",
        "description":"Double bend type mtb handle/front- disc, rear- side pull v-brake.18 speed index type shift system from shimano.Tyre: 24 inchx 1.95 inch, latest treads for better road grip and extra stability on bumpy road.Comfortable mtb style pu molded saddle kindly note, this product will be shipped in a semi assembled/dismantled state.Box Content: 1 Mountain Bike. Note : Suppliers/ parts are subject to change, expect change in color of tire.",
        "product_type":"",
        "image_url":"https://m.media-amazon.com/images/I/51w650czO7L._AC_UY218_ML3_.jpg"
    },
    {
        "id":11,
        "name":"HONOR Band 5",
        "price":"2,599.00",
        "description":"HONOR BAND 5 is a High-End AMOLED Full Color Display Smart Band with 50m Water Resistance, Full Screen Touch & Home Button Control. Integrating smart features such as Heart Rate Monitoring, Fitness & Swimming Monitoring, Sleep Monitoring and Smart Notifications & Message Reminders, it is the best device that helps users to understand & monitor their fitness and health status. You can download and install the Huawei Health-App. With this app, you can connect your band with your phone (Running Android 4.4 or later / iOS 9.0 or later) and better manage your band & fitness regime.",
        "product_type":"",
        "image_url":"https://m.media-amazon.com/images/I/81y0sMvkW1L._AC_UL320_ML3_.jpg"
    },
    {
        "id":12,
        "name":"Fitkit FT200 Series Motorized Treadmill",
        "price":"28,490.00",
        "description":"FT200 Series Foldable Motorized Treadmill serves the deadly combination of good looks and functionality, it is ideal for domestic use, easy to store. The treadmill is an example of durability and strength as it is equipped with stable steel frames. It has Pulse rate monitor to maintain your target heart rate, and LCD screen displays- time, speed, distance, calories and heart rate measurement. Its Speed is 1-16km/hr., this treadmill can accommodate any user, from beginners to pros, from walkers to runners with a wide 1240*420mm running surface, it gives you plenty of space to walk or run for all types of users. You’ll get all you'll need to stay focused and on track. The unique features and performance of treadmill attracts many customers",
        "product_type":"",
        "image_url":"https://images-eu.ssl-images-amazon.com/images/I/41afIvgluhL._AC._AC._SR360,460.jpg"
    },
    {
        "id":13,
        "name":"Healthgenie 3412MT 4 in 1 Manual Treadmill",
        "price":"11,122.00",
        "description":"Healthgenie 4in1 Manual treadmill is a non-motorized treadmill machine for home use comes with three additional features such as Twister, Stepper and Push Up Bars. It comes with a console display used to monitor speed, distance, calories, time and pulse. Stepper is perfect in improving heart and circulatory function and ideal in strengthening leg muscles. Twister helps to slim the thighs, waist and hips. It comes with 3 level manual incline feature for power training. It is foldable, easy to store and has wheels for easy portability. Pulse Sensors are present on the handle that calculate pulse rate while running. Platform Size of treadmill id 114x33.7cm",
        "product_type":"",
        "image_url":"https://images-eu.ssl-images-amazon.com/images/I/61dwckXHKCL._AC._SR360,460.jpg"
    },
    {
        "id":14,
        "name":"PICKVILL Exercise Ball",
        "price":"425.00",
        "description":"A gym ball is an exceptionally versatile fitness training accessory that allows users to do an endless number of exercises for all parts of the body and even helps in rehabilitation. If you are looking for a reliable gym ball, a suitable choice could be this imported gym ball. Functions and usability this gym ball measures 65 cm in diameter and can be used to a number of stretching exercises, Pilates and rehabilitative exercises. This inflatable anti burst gym ball comes with a foot pump that allows you to pump air into the ball with ease. You can easily carry the ball wherever you choose and enjoy a comprehensive workout anytime.",
        "product_type":"",
        "image_url":"https://images-eu.ssl-images-amazon.com/images/I/712fjj9si4L._AC._SR360,460.jpg"
    },
    {
        "id": 15,
        "name":"Vectora B44 Lycra-Spandex Sweat Waist Fat Burner",
        "price":"63.00",
        "description":"Vectora sweat waist fat burner body slimming belt. Material: Lycra-spandex. Colour: Black. Made by vectora. Assured with brand. Good to buy",
        "product_type":"",
        "image_url":"https://images-eu.ssl-images-amazon.com/images/I/71vAkWmzNNL._AC._SR360,460.jpg"
    }
]

""".data(using: .utf8)!
