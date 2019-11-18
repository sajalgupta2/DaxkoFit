//
//  FitShop.swift
//  Daxko_FitSection
//
//  Created by Sajal Gupta on 13/11/2019.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import Foundation


struct FitShop: Decodable {
    
    let id: Int
    let name: String
    let price: String
    let imageUrl: String
    let description: String
    let productType: String
    
    var formattedPrice: String {
        return "$ \(price)"
    }
   
    enum CodingKeys :String, CodingKey {
        case id = "id"
        case name = "name"
        case price = "price"
        case imageUrl = "image_url"
        case description = "description"
        case productType = "product_type"
    }
    
    init() {
        self.id = 1
        self.name = ""
        self.price = "24"
        self.imageUrl = ""
        self.description = ""
        self.productType = ""
        
    }
}
 


    
    //["T-Shirt", "Cycle", "Apple Air pods", "Sony BDV", "American Touristor", "Samsung Tab", "Apple iPad", "Rayban", "Cannon EOS", "Go Pro", "Seagate", "WD Hard disk", "Macbook"]
   
 //  var priceArray = ["$100","$600","$700","$1500","$1700","$800","$400","$900","$100","$200","$500","$890","$750"]
