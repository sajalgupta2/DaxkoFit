//
//  PhotoBrowse+Extension.swift
//  Daxko_FitSection
//
//  Created by Anurag Kashyap on 15/11/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit
import GlidingCollection
import YPImagePicker

class PhotoBrowse_Extension: UIViewController {

    
    @IBOutlet var glidingView: GlidingCollection!
    fileprivate var collectionView: UICollectionView!
    fileprivate var items = ["gloves", "boots", "bindings", "hoodie"]
    fileprivate var images: [[UIImage?]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGlidingCollectionView()
        loadImages()
    }
}


extension PhotoBrowse_Extension {
    
    private func setupGlidingCollectionView() {
      glidingView.dataSource = self
      
      let nib = UINib(nibName: "CollectionCell", bundle: nil)
      collectionView = glidingView.collectionView
      collectionView.register(nib, forCellWithReuseIdentifier: "Cell")
      collectionView.delegate = self
      collectionView.dataSource = self
      collectionView.backgroundColor = glidingView.backgroundColor
    }
    
    private func loadImages() {
        
       for item in items {
         let imageURLs = FileManager.default.fileUrls(for: "jpeg", fileName: item)
         var images: [UIImage?] = []
         for url in imageURLs {
           guard let data = try? Data(contentsOf: url) else { continue }
           let image = UIImage(data: data)
           images.append(image)
         }
         self.images.append(images)
       }
     }
}


// MARK: - Gliding Collection 🎢
extension PhotoBrowse_Extension: GlidingCollectionDatasource {
  
    func numberOfItems(in collection: GlidingCollection) -> Int {
        return items.count
    }
  
    func glidingCollection(_ collection: GlidingCollection, itemAtIndex index: Int) -> String {
        return "– " + items[index]
    }
}


// MARK: - CollectionView 🎛
extension PhotoBrowse_Extension: UICollectionViewDataSource, UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let section = glidingView.expandedItemIndex
    return images[section].count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionCell else { return UICollectionViewCell() }
    
    let section = glidingView.expandedItemIndex
    let image = images[section][indexPath.row]
    cell.imageView.image = image
    cell.contentView.clipsToBounds = true
    cell.configureCell(collectionCell: cell)
    return cell
  }
    
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let section = glidingView.expandedItemIndex
    let item = indexPath.item
    print("Selected item #\(item) in section #\(section)")
  }
}
