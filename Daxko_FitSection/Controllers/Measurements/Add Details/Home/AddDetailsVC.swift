//
//  AddDetailsVC.swift
//  Daxko_FitSection
//
//  Created by Anurag Kashyap on 14/11/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit



class AddDetailsVC: UIViewController {
    
    @IBOutlet weak var progressPhotoView : UIView!
    @IBOutlet weak var weightLabel : UILabel!
    @IBOutlet weak var heightLabel : UILabel!
    @IBOutlet weak var genderLabel : UILabel!
    @IBOutlet weak var ageLabel : UILabel!
    @IBOutlet weak var neckLabel : UILabel!
    @IBOutlet weak var waistLabel : UILabel!
    @IBOutlet weak var bodyFatLabel : UILabel!
    @IBOutlet weak var idealWeightLabel : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        //hideLabels()
        gestureToView()
    }
    
    func gestureToView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.progressPhotoViewTapped))
        progressPhotoView.addGestureRecognizer(tap)
        progressPhotoView.isUserInteractionEnabled = true
    }
    

    @objc func progressPhotoViewTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let vc = UIStoryboard.init(name: measurementStroryBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: photoBrowseVC) as? PhotoBrowseVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func hideLabels() {
        weightLabel.isHidden = true
        heightLabel.isHidden = true
        genderLabel.isHidden = true
        ageLabel.isHidden = true
        neckLabel.isHidden = true
        waistLabel.isHidden = true
        bodyFatLabel.isHidden = true
        idealWeightLabel.isHidden = true
    }
}
