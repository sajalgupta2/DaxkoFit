//
//  MyCartTableViewCell.swift
//  Daxko_FitSection
//
//  Created by Anurag Kashyap on 11/11/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit

protocol myCartTableViewCellDelegate : class {
    func didPressRemoveButton(_ tagValue: Int)
}

class MyCartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var procustImageView : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var removeButton : UIButton!
    @IBOutlet weak var sizeButtonOutlet : UIButton!
    @IBOutlet weak var quantityButtonOutlet : UIButton!
    
    @IBOutlet weak var sizeTFOutlet : DropDown!
    @IBOutlet weak var quantityTFOutlet : DropDown!
    
    var sizeArray = ["S","M","L","XL","XXL"]
    var quantityArray = ["1","2","3","4"]
    
    var myCartDelegate: myCartTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        sizeTFOutlet.optionArray = sizeArray
        quantityTFOutlet.optionArray = quantityArray
        
        sizeTFOutlet.delegate = self
        quantityTFOutlet.delegate = self
        
        quantityTFOutlet.didSelect{(selectedText , index ,id) in
            self.quantityTFOutlet.text = "\(selectedText)"
        }
        
        sizeTFOutlet.didSelect{(selectedText , index ,id) in
            self.sizeTFOutlet.text = "\(selectedText)"
        }
        
        self.setCardView()
    }
    
    @IBAction func removeButtonPressed(_ sender: UIButton) {
        myCartDelegate?.didPressRemoveButton(sender.tag)
    }
}

extension MyCartTableViewCell : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
    
}
