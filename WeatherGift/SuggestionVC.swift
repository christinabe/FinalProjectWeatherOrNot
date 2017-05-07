//
//  SuggestionVC.swift
//  WeatherGift
//
//  Created by CSOM on 4/26/17.
//  Copyright © 2017 CSOM. All rights reserved.
//

import UIKit

class SuggestionVC: UIViewController {

    @IBOutlet weak var backButtonSuggestion: UIButton!
    
    @IBOutlet weak var ideaButton: UIButton!
    
    //var temperature = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonSuggestion.setImage(UIImage(named:"left-arrow"), for: .normal)
        ideaButton.setImage(UIImage(named: "idea"), for: .normal)
        
       // print(temperature)
    
        
        
    }
// how to show alert if it is greater than 50% rain
    
    
  
// remember to convert to CGFloat
    
    
    @IBAction func backButtonPressedSuggestion(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)

    }
    
    


}
