//
//  CoachDetailsVC.swift
//  Daxko_FitSection
//
//  Created by Anurag Kashyap on 10/11/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit

let coachDetailsVC = "CoachDetailsVC"

class CoachDetailsVC: UIViewController {

    @IBOutlet weak var coachImageView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func enrollCoachAction(_ sender: UIBarButtonItem) {

        let vc = UIStoryboard.init(name: fitStroryBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: paymentVC) as? PaymentVC
              self.navigationController?.pushViewController(vc!, animated: true)
    }
}

extension CoachDetailsVC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoachDetailsTableViewCell", for: indexPath) as! CoachDetailsTableViewCell
        
        cell.coachNameLabel.text = "Anurag Kashyap"
        cell.descriptionLabel.text = "Description : Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
        
            return cell
        }
    
}
