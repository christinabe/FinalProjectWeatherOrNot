//
//  ShoesVC.swift
//  WeatherGift
//
//  Created by CSOM on 4/30/17.
//  Copyright © 2017 CSOM. All rights reserved.
//

import UIKit

class ShoesVC: UIViewController {

    @IBOutlet weak var shoeCollectionView: UICollectionView!
    
    var temperature: Double = 0.0

    
    let shoeArrayImages = [UIImage(named:"shoe"), UIImage(named:"flipflops0"), UIImage(named:"rainBoots0")]
    
    let warmShoeArrayImages = [UIImage(named:"flipflops0")]
    let wetShoeArrayImages = [UIImage(named:"shoe"), UIImage(named:"boot")]

    override func viewDidLoad() {
        super.viewDidLoad()

        shoeCollectionView.dataSource = self
        shoeCollectionView.delegate = self
        
       print("TEMPERATURE \n", temperature)
        
       
//        switch shoeTemp {
//        case 70...Int.max:
//        case 0...70:
//        }
        
        //if temperature > 70 {
            
        //}
        

    }

    @IBAction func backButtonPressedShoes(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}

extension ShoesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if temperature > 70 {
           return warmShoeArrayImages.count
        } else {
            return wetShoeArrayImages.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let shoeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShoeCell", for: indexPath) as! ShoeCollectionViewCell
//        if temperature > 70 ° {
//            shoeCell.shoeImage.image = warmShoeArrayImages[indexPath.row]
//        } else {
        if temperature > 70 {
            shoeCell.shoeImage.image = warmShoeArrayImages[indexPath.row]
        } else {
            shoeCell.shoeImage.image = wetShoeArrayImages[indexPath.row]
        }
       return shoeCell
    }
}

