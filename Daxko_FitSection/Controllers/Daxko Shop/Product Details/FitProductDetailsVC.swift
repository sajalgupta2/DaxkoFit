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

    @IBOutlet weak var tableView : UITableView!
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         title = ""
        setupHeaderView()
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
    }
}

extension FitProductDetailsVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FitShopTableViewCell", for: indexPath) as! FitShopTableViewCell
        return cell
    }
}

extension FitProductDetailsVC {
    
      // MARK: - Parallax header delegate
      
      func parallaxHeaderDidScroll(_ parallaxHeader: MXParallaxHeader) {
          NSLog("progress %f", parallaxHeader.progress)
      }
    
}
