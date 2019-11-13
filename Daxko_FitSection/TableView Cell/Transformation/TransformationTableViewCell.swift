//
//  TransformationTableViewCell.swift
//  Daxko_FitSection
//
//  Created by Anurag Kashyap on 09/11/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit

protocol TransformationTableViewCellDelegate : class {
    func didPressShareButton(_ tagValue: Int)
}

class TransformationTableViewCell: UITableViewCell {

    @IBOutlet weak var shareButtonOutlet : UIButton!
    var cellShareDelegate: TransformationTableViewCellDelegate?
    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        cellShareDelegate?.didPressShareButton(sender.tag)
    }
}
