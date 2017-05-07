//
//  CasualVC.swift
//  WeatherGift
//
//  Created by CSOM on 4/24/17.
//  Copyright © 2017 CSOM. All rights reserved.
//

import UIKit

class AccessoriesVC: UIViewController {

    @IBOutlet weak var casualCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func backButtonPressedCasual(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }

}

extension AccessoriesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let casualCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CasualCell", for: indexPath)
        return casualCell
    }
}


