//
//  PhotoBrowseVC.swift
//  Daxko_FitSection
//
//  Created by Anurag Kashyap on 14/11/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit
import YPImagePicker

let photoBrowseVC = "PhotoBrowseVC"

class PhotoBrowseVC: PhotoBrowse_Extension {

    var config = YPImagePickerConfiguration()
    
    var imageSelected = false {
           didSet {
            //do Something here
           }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func uploadImageButtonAction(_ sender: UIBarButtonItem) {
        handleSelectPhotoToPost()
    }
    
    @IBAction func myCartBarButtonAction(_ sender: UIBarButtonItem) {
        let vc = UIStoryboard.init(name: fitStroryBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: myCartVC) as? MyCartVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

//MARK: YPImagePicker Camera
extension PhotoBrowseVC {
    
    func handleSelectPhotoToPost() {
        
        config.startOnScreen = .library
        config.screens = [.library,.photo]
        config.library.mediaType = .photo
        config.library.maxNumberOfItems = 5
        /* Enables you to opt out from saving new (or old but filtered) images to the
         user's photo library. Defaults to true. */
        config.shouldSaveNewPicturesToAlbum = false
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, _ in
            
            for item in items {
                switch item {
                case .photo(let photo):
                    self.imageSelected = true
                    print(photo.image)
                default :
                    break
                }
            }
            
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
}
