//
//  TicketsVC.swift
//  Daxko_FitSection
//
//  Created by Anurag Kashyap on 11/11/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit

class TicketsVC: UIViewController {

    @IBOutlet weak var myWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
    }
    
    func setupWebView(){
        let url = URL (string: "https://www.daxko.com/company")
        let requestObj = URLRequest(url: url!)
        myWebView.loadRequest(requestObj)
    }
}
