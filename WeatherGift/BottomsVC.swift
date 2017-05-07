//
//  InterviewVC.swift
//  WeatherGift
//
//  Created by CSOM on 4/24/17.
//  Copyright © 2017 CSOM. All rights reserved.
//

import UIKit

class BottomsVC: UIViewController {
    
    @IBOutlet weak var interviewCollectionView: UICollectionView!
    
    var temperature: Double = 0.0
    
    let arrayImages = [UIImage(named:"dress0"), UIImage(named:"pants0"), UIImage(named:"pants1"), UIImage(named:"pants2"), UIImage(named:"pants3"), UIImage(named:"shorts0"), UIImage(named:"shorts1"), UIImage(named:"skirt0")]
    //how to return images based on temperature
    let coldArrayImages = [UIImage(named:"pants0"), UIImage(named:"pants1"), UIImage(named:"pants2"), UIImage(named:"pants3")]
    
    let warmArrayImages = [UIImage(named:"dress0"), UIImage(named:"shorts0"), UIImage(named:"shorts1"), UIImage(named:"skirt0")]
    
   //var temperature = ""
   
    
    //add all images here for this screen
    override func viewDidLoad() {
        super.viewDidLoad()
            
            interviewCollectionView.dataSource = self
            interviewCollectionView.delegate = self
        
//        let strArr = split(temperature) { $0 == " " }
//        
//        for item in strArr {
//            let components = item.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet)
//            let part = "".join(components)
//            if let intVal = part.toInt() {
//                println("this is a number -> \(intVal)")
//            }
//        }

        
       // let temperature =
   
      //  print(temperature)
        
    }


    @IBAction func backButtonPressedInterview(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
}

extension BottomsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if temperature > 70 {
            return warmArrayImages.count
        } else {
            return coldArrayImages.count 
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let bottomsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BottomsCell", for: indexPath) as! PantsCollectionViewCell
        if temperature > 70 {
            bottomsCell.imageView.image = warmArrayImages[indexPath.row]
        } else {
            bottomsCell.imageView.image = coldArrayImages[indexPath.row]
      //  interviewCell.imageView.image = arrayImages[indexPath.row]
        }
            return bottomsCell
    }
}

