//
//  FitProductDetailsVC.swift
//  Daxko_FitSection
//
//  Created by Anurag Kashyap on 10/11/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit
import MXParallaxHeader

let fitProductDetailsVC = "FitProductDetailsVC"

class FitProductDetailsVC: UIViewController, MXParallaxHeaderDelegate {

    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var headerPriceLabel: UILabel!
    
    
    var fitShop: FitShop = FitShop()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         title = ""
        setupHeaderView()
    }
    
    @IBAction func cartBarButtonAction(_ sender: UIBarButtonItem) {
       let vc = UIStoryboard.init(name: fitStroryBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: myCartVC) as? MyCartVC
       self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func addCartButtonAction(_ sender: UIButton) {
       let vc = UIStoryboard.init(name: fitStroryBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: myCartVC) as? MyCartVC
       self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func buyButtonAction(_ sender: UIButton) {
          let vc = UIStoryboard.init(name: fitStroryBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: paymentVC) as? PaymentVC
          self.navigationController?.pushViewController(vc!, animated: true)
    }
       
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        tableView.parallaxHeader.minimumHeight = view.safeAreaInsets.top
    }
    
    func setupHeaderView(){
        // Parallax Header
        tableView.parallaxHeader.view = headerView // You can set the parallax header view from the floating view
        tableView.parallaxHeader.height = 350
        tableView.parallaxHeader.mode = .fill
        tableView.parallaxHeader.delegate = self
        productNameLabel.text = fitShop.name
        headerPriceLabel.text = fitShop.price
        headerImageView.sd_setImage(with: URL(string: fitShop.imageUrl), placeholderImage: nil)
    }
}

extension FitProductDetailsVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FitShopTableViewCell", for: indexPath) as! FitShopTableViewCell
        cell.productDetailsLabel.text = fitShop.description
        return cell
    }
}

extension FitProductDetailsVC {
    
      // MARK: - Parallax header delegate
      
      func parallaxHeaderDidScroll(_ parallaxHeader: MXParallaxHeader) {
          NSLog("progress %f", parallaxHeader.progress)
      }
    
}
