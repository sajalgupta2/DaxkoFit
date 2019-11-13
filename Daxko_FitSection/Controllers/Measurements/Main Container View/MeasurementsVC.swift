//
//  MeasurementsVC.swift
//  Daxko_FitSection
//
//  Created by Anurag Kashyap on 08/11/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit

let measurementStroryBoardName = "Measurements"
let measurementVC = "MeasurementsVC"

class MeasurementsVC: UIViewController {

    @IBOutlet weak var addDetailsCV : UIView!
    @IBOutlet weak var trackProgressCV : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func segmentedControlAction(_ sender : UISegmentedControl){
        
        switch sender.selectedSegmentIndex {
            
        case 0:
            
            addDetailsCV.isHidden = true
            trackProgressCV.isHidden = false
            print("index is : \(sender.selectedSegmentIndex)")
            
        default:
            
            addDetailsCV.isHidden = false
            trackProgressCV.isHidden = true
            print("else index is : \(sender.selectedSegmentIndex)")
        }
    }
}
