//
//  FitShop.swift
//  Daxko_FitSection
//
//  Created by Sajal Gupta on 13/11/2019.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import Foundation

struct FitShopDetails {
   
    let shopName: String
    let price: Int
   
    var formattedPrice: String {
        return "$ \(price)"
    }
}


    
    //["T-Shirt", "Cycle", "Apple Air pods", "Sony BDV", "American Touristor", "Samsung Tab", "Apple iPad", "Rayban", "Cannon EOS", "Go Pro", "Seagate", "WD Hard disk", "Macbook"]
   
 //  var priceArray = ["$100","$600","$700","$1500","$1700","$800","$400","$900","$100","$200","$500","$890","$750"]
