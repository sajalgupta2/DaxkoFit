//
//  CoachesVC.swift
//  Daxko_FitSection
//
//  Created by Anurag Kashyap on 08/11/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit

let trainerStroryBoardName = "Trainer"
let trainerVC = "TrainerVC"

class TrainerVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cartBarButtonAction(_ sender: UIBarButtonItem) {
       let vc = UIStoryboard.init(name: fitStroryBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: myCartVC) as? MyCartVC
       self.navigationController?.pushViewController(vc!, animated: true)
    }
}

//MARK: Datasource
extension TrainerVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FitnessExercise.fetchExercises().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrainerCollectionViewCell", for: indexPath) as! TrainerCollectionViewCell
        cell.descriptionLabel.text = FitnessExercise.fetchExercises()[indexPath.row].title
        cell.coachImageView.image = FitnessExercise.fetchExercises()[indexPath.row].backgroundImage
        return cell
    }
}


extension TrainerVC : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let vc = UIStoryboard.init(name: nutritionistStroryBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: nutritionistVC) as? NutritionistVC
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
}
