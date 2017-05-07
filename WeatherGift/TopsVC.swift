//
//  GoingOutVC.swift
//  WeatherGift
//
//  Created by CSOM on 4/24/17.
//  Copyright © 2017 CSOM. All rights reserved.
//

import UIKit

class TopsVC: UIViewController {
    
    
    @IBOutlet weak var topsCollectionView: UICollectionView!
    
  
    
    
    var temperature: Double = 0.0
    
   // @IBOutlet weak var scrollView: UIScrollView!
    
   let topArrayImages = [UIImage(named:"coat0"), UIImage(named:"hoodie-0)"), UIImage(named:"hoodie1"), UIImage(named:"jacket0"), UIImage(named:"shirt0"),UIImage(named:"sweater0"),UIImage(named:"tank0"),UIImage(named:"tshirt0"),UIImage(named:"tshirt1"),UIImage(named:"vest0")]
    
    let warmTopArrayImages = [UIImage(named:"shirt0"),UIImage(named:"tank0"),UIImage(named:"tshirt0"),UIImage(named:"tshirt1")]
    
    let mildTopArrrayImages = [UIImage(named:"hoodie-0)"), UIImage(named:"hoodie1"), UIImage(named:"jacket0"), UIImage(named:"sweater0"), UIImage(named:"vest0")]
    
    let coldTopArrayImages = [UIImage(named:"coat0")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topsCollectionView.dataSource = self
        topsCollectionView.delegate = self
        
//        image1.frame = CGRect(x: 15, y: 20, width: self.view.frame.width - 30, height: 250)
//        
//        image2.frame = CGRect(x: 15 + self.view.frame.width, y: 20, width: self.view.frame.width - 30, height: 250)
//        
//        image3.frame = CGRect(x: 15 + (2 * self.view.frame.width), y: 20, width: self.view.frame.width - 30, height: 250)
//        
//        image4.frame = CGRect(x: 15 + (3 * self.view.frame.width), y: 20, width: self.view.frame.width - 30, height: 250)
//
//        scrollView.contentSize = CGSize (width: self.view.frame.width * 4, height: 0)
        
    }

 
    @IBAction func backButtonPressedGoingOut(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }

}

extension TopsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if temperature > 70 {
            return warmTopArrayImages.count
            
        } else if temperature > 50 && temperature < 70 {
            return mildTopArrrayImages.count
        } else {
            return coldTopArrayImages.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let topsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopsCell", for: indexPath) as!TopsCollectionViewCell
        if temperature > 70 {
            topsCell.imageViewTop.image = warmTopArrayImages[indexPath.row]
        } else if temperature > 50 && temperature < 70 {
            topsCell.imageViewTop.image = mildTopArrrayImages[indexPath.row]
    } else {
     topsCell.imageViewTop.image = coldTopArrayImages[indexPath.row]
    }
        return topsCell
    }
}
