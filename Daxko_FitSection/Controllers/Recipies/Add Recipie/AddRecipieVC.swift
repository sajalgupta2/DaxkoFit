//
//  AddRecipieViewController.swift
//  Daxko_FitSection
//
//  Created by Anurag Kashyap on 08/11/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit

let addRecipieVC = "AddRecipieVC"

class AddRecipieVC: UIViewController {

    @IBOutlet weak var addRecipieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension AddRecipieVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = addRecipieTableView.dequeueReusableCell(withIdentifier: "RecipieDescriptionTableViewCell", for: indexPath) as! RecipieDescriptionTableViewCell
            return cell
            
        case 1:
            let cell = addRecipieTableView.dequeueReusableCell(withIdentifier: "RecipieIngredientsTableViewCell", for: indexPath) as! RecipieIngredientsTableViewCell
            return cell
        
        case 2:
            let cell = addRecipieTableView.dequeueReusableCell(withIdentifier: "RecipieProcessTableViewCell", for: indexPath) as! RecipieProcessTableViewCell
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}
