//
//  MyCartVC.swift
//  Daxko_FitSection
//
//  Created by Anurag Kashyap on 11/11/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit

let myCartVC = "MyCartVC"

class MyCartVC: UIViewController {

    @IBOutlet weak var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "My Cart"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = "Back"
    }
    
    @IBAction func placeOrderButtonAction(_ sender: UIButton) {
          let vc = UIStoryboard.init(name: fitStroryBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: paymentVC) as? PaymentVC
          self.navigationController?.pushViewController(vc!, animated: true)
    }
       
}

extension MyCartVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCartTableViewCell", for: indexPath) as! MyCartTableViewCell
        cell.myCartDelegate = self
        cell.removeButton.tag = indexPath.row
        return cell
    }
}

extension MyCartVC : myCartTableViewCellDelegate {
    
    func didPressRemoveButton(_ tagValue: Int) {
        print("Remove Tag Value is : \(tagValue)")
    }
}
