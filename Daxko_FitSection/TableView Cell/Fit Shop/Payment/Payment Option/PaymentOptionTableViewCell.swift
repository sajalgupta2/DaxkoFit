//
//  PaymentTableViewCell.swift
//  Daxko_FitSection
//
//  Created by Anurag Kashyap on 10/11/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit

class PaymentOptionTableViewCell: UITableViewCell {

    @IBOutlet weak var paymentOptionCollectionView : UICollectionView!
    var paymentOptionArray = ["Card","Paytm","Netbanking","UPI","EMI","Paypal"]
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.paymentOptionCollectionView.delegate = self
        self.paymentOptionCollectionView.dataSource = self
    }
}

extension PaymentOptionTableViewCell : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return paymentOptionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = paymentOptionCollectionView.dequeueReusableCell(withReuseIdentifier: "PaymentCollectionViewCell", for: indexPath) as! PaymentCollectionViewCell
        cell.titleLabel.text = paymentOptionArray[indexPath.row]
        cell.paymentOptionImageView.image = UIImage(named: paymentOptionArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Section: \(indexPath.section)")
        print("Row: \(indexPath.row)")
    }
}
