//
//  EventsVC.swift
//  Daxko_FitSection
//
//  Created by Anurag Kashyap on 11/11/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit

let eventsStroryBoardName = "Events"
let eventsListVC = "EventsListVC"

class EventsListVC: UIViewController {

    @IBOutlet weak var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension EventsListVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventsListTableViewCell", for: indexPath) as! EventsListTableViewCell
        return cell
    }
}
