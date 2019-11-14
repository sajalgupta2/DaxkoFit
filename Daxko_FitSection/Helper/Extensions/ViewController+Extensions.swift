//
//  ViewController+Extensions.swift
//  Daxko_FitSection
//
//  Created by Anurag Kashyap on 08/11/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit

extension UIViewController  {

    /// Open action sheet for filter the items
    /// - Parameters:
    ///   - title: Title of the sheet
    ///   - message: Description
    ///   - alphabetical: sort list  A-Z
    ///   - price: sort list  as per the price
     func filterActioSheet(title: String? = nil, message: String? = nil, alphabetical: @escaping (() -> Void), price: @escaping (() -> Void)) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
           
            alert.addAction(UIAlertAction(title: "Sort by Alphabetically", style: .default, handler: { action in
                alphabetical()
            }))
          
            alert.addAction(UIAlertAction(title: "Sort by Price", style: .default, handler: { action in
                price()
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                
            }))
                self.present(alert, animated: true, completion: nil)
        }

}

