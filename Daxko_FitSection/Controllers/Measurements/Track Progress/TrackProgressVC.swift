//
//  TrackProgressVC.swift
//  Daxko_FitSection
//
//  Created by Anurag Kashyap on 11/11/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit

class TrackProgressVC: TrackProgressVC_Extensions {

    @IBOutlet weak var tableView : UITableView!
    @IBOutlet var headerGraphView: ScrollableGraphView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        headerGraphView.dataSource = self
        setupGraph(graphView: headerGraphView)
    }
}

extension TrackProgressVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackProgressTableViewCell", for: indexPath) as! TrackProgressTableViewCell
        cell.graphView.dataSource = self
        return cell
    }
}
