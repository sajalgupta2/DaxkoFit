//
//  Recipies+Extensions.swift
//  Daxko_FitSection
//
//  Created by Anurag Kashyap on 08/11/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import Foundation
import UIKit

class Recipies_Extensions: UIViewController {
    
}

extension Recipies_Extensions {
    
    func pushNavigationController(storyBoardName : String, viewControllerIdentifier: String, caseValue : Int) {
        
        switch caseValue {
        case 0:
            if let vc = UIStoryboard.init(name: storyBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: viewControllerIdentifier) as? AddRecipieVC{
                self.present(vc, animated: true, completion: nil)
            }

        case 1:
            if let vc = UIStoryboard.init(name: storyBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: viewControllerIdentifier) as? RecipieListVC{
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            
        default:
            if let vc = UIStoryboard.init(name: storyBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: viewControllerIdentifier) as? RecipielnfoVC{
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
}
