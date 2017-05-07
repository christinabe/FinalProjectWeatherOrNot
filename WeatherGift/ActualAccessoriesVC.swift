//
//  ActualAccessoriesVC.swift
//  WeatherGift
//
//  Created by CSOM on 5/1/17.
//  Copyright © 2017 CSOM. All rights reserved.
//

import UIKit

class ActualAccessoriesVC: UIViewController {

    
    @IBOutlet weak var accessoriesCollectionView: UICollectionView!
    
    
    
    
    var temperature: Double = 0.0
    
    
    
    let accessoryArrayImages = [UIImage(named:"earmuffs0"), UIImage(named: "scarf0"), UIImage(named:"sunglasses"), UIImage(named:"sunScreen0"), UIImage(named:"winterHat0"),UIImage(named:"water")]
    
    let warmAccessoryArrayImages = [UIImage(named:"sunglasses"), UIImage(named:"sunScreen0"), UIImage(named:"water")]
   
    let mildAccessoryArrayImages = [UIImage(named:"water")]
    
    let coldAccessoryArrayImages = [UIImage(named:"earmuffs0"), UIImage(named: "scarf0"), UIImage(named:"winterHat0"),UIImage(named:"water")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accessoriesCollectionView.dataSource = self
        accessoriesCollectionView.delegate = self
        print()
        print("_____________________________")
        print("The temperature is: ", temperature)

        
    }
    

    @IBAction func backButtonPressedAccessories(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }


}

extension ActualAccessoriesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if temperature > 65 {
            return warmAccessoryArrayImages.count
        } else {
            return coldAccessoryArrayImages.count
        }
        
        //if temperature > 70 {
//            return warmAccessoryArrayImages.count
//        } else if temperature > 50 && temperature < 70 {
//            return mildAccessoryArrayImages.count
//        } else {
//            return coldAccessoryArrayImages.count
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let accessoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AccessoriesCell", for: indexPath) as! AccessoriesCollectionViewCell
        if temperature > 65 {
            accessoryCell.imageViewAccessories.image = warmAccessoryArrayImages[indexPath.row]
        } else {
            accessoryCell.imageViewAccessories.image = coldAccessoryArrayImages[indexPath.row]
        }
        
        //        if temperature > 70 {
//            accessoryCell.imageViewAccessories.image = warmAccessoryArrayImages[indexPath.row]
//        } else if temperature > 50 {
//            accessoryCell.imageViewAccessories.image = mildAccessoryArrayImages[indexPath.row]
//        } else {
//            accessoryCell.imageViewAccessories.image = coldAccessoryArrayImages[indexPath.row]
//        }
        return accessoryCell
    }
}
