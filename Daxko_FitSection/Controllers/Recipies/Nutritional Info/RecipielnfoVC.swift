//
//  RecipielnfoVC.swift
//  Daxko_FitSection
//
//  Created by Anurag Kashyap on 08/11/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit

let recipiesInfoVC = "RecipielnfoVC"

class RecipielnfoVC: UIViewController {

    var sectionTitle = ["Nutritional Info","Ingredients","Prepration Method"]
    
    var nutritionArray = ["Protein","Fats","Carbs", "Fiber"]
    var ingredientsArray = ["Ghee","Garam Masala","Water", "Salt","Pepper", "Coriander leaves"]
    var preprationArray = ["Marinate the chicken by adding masala","Add water", "Add Ghee","Heat the pan for 2 mins", "Your chicken is ready to be served"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension RecipielnfoVC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return nutritionArray.count
        case 1:
            return ingredientsArray.count
        case 2:
            return preprationArray.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipieInfoTableViewCell", for: indexPath) as! RecipieInfoTableViewCell
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = nutritionArray[indexPath.row]
            return cell
        case 1:
            cell.textLabel?.text = ingredientsArray[indexPath.row]
            return cell
        case 2:
            cell.textLabel?.text = preprationArray[indexPath.row]
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension RecipielnfoVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
      }
    
}
