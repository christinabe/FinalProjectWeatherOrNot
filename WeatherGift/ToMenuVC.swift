//
//  ToMenuVC.swift
//  WeatherGift
//
//  Created by CSOM on 4/24/17.
//  Copyright © 2017 CSOM. All rights reserved.
//

import UIKit

class ToMenuVC: UIViewController {

    @IBOutlet weak var backButtonMenu: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonMenu.setImage(UIImage(named:"left-arrow"), for: .normal)

        
    }

 
    @IBAction func backButtonPressedToMenu(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
    


}
