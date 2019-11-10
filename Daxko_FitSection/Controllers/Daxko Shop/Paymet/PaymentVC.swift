//
//  PaymentVC.swift
//  Daxko_FitSection
//
//  Created by Anurag Kashyap on 10/11/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit

let paymentVC = "PaymentVC"

class PaymentVC: UIViewController {

    @IBOutlet weak var tableView : UITableView!
    
    var sectionTitle = ["Confirmation to be sent on","Select a Payment Method"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension PaymentVC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section < 1 {
            
             if let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentConfirmationTableViewCell", for: indexPath) as? PaymentConfirmationTableViewCell {
                 return cell
             }
             
         }else {
             
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentOptionTableViewCell", for: indexPath) as? PaymentOptionTableViewCell {
                return cell
            }
             
         }
         
        return UITableViewCell()
    }
}

extension PaymentVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
      }
}
