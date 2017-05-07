//
//  DetailVC.swift
//  WeatherGift
//
//  Created by CSOM on 3/19/17.
//  Copyright © 2017 CSOM. All rights reserved.
//

import UIKit
import CoreLocation

class DetailVC: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var currentImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
   
    @IBOutlet weak var shoeLabel: UIButton!
    @IBOutlet weak var shirtLabel: UIButton!
    @IBOutlet weak var pantsLabel: UIButton!
    @IBOutlet weak var accessoriesLabel: UIButton!
    
    var currentPage = 0
    var locationsArray = [WeatherLocation] ()
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        locationManager.delegate = self
        shoeLabel.setImage(UIImage(named: "shoe"), for: .normal)
        shirtLabel.setImage(UIImage(named: "shirt"), for: .normal)
        pantsLabel.setImage(UIImage(named: "jean"), for: .normal)
        accessoriesLabel.setImage(UIImage(named: "sunglasses"), for: .normal)
       
        locationsArray[currentPage].getWeather {
            self.updateUserInterface()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if currentPage == 0 {
            getLocation()
        }
    }
    
    func updateUserInterface() {
        
        let isHidden = (locationsArray[currentPage].currentTemp == -999.9)
        temperatureLabel.isHidden = isHidden
        locationLabel.isHidden = isHidden
       
        
        locationLabel.text = locationsArray[currentPage].name
        
        if locationsArray[currentPage].currentTime == 0.0 {
            dateLabel.text = ""
        } else {
            dateLabel.text = formatTimeForTimeZone(unixDateToFormat: locationsArray[currentPage].currentTime, timeZoneString: locationsArray[currentPage].timeZone)

        }
   
        
        let curTemperature = String(format: "%3.f", locationsArray[currentPage].currentTemp) + "°"
        temperatureLabel.text = curTemperature
        //must convert bc double -> string
        
        summaryLabel.text = locationsArray[currentPage].dailySummary
        currentImage.image = UIImage(named: locationsArray[currentPage].currentIcon)
        tableView.reloadData()
        collectionView.reloadData()
    }
    func formatTimeForTimeZone(unixDateToFormat: TimeInterval, timeZoneString: String) -> String {
        let usableDate = Date(timeIntervalSince1970: unixDateToFormat)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM dd, y"
        dateFormatter.timeZone = TimeZone(identifier: timeZoneString)
        let dateString = dateFormatter.string(from: usableDate)
        return dateString
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(alertAction)
        
        present(alertController, animated: true, completion: nil)
    }
}


extension DetailVC: CLLocationManagerDelegate{
    
    func getLocation() {
        let status = CLLocationManager.authorizationStatus()
        
        handleLocationAuthorizationStatus(status: status)
    }
    
    func handleLocationAuthorizationStatus(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied:
            if currentPage == 0 && self.view.window != nil {
                showAlert(title: "User has not authorized location services", message: "open the settings app > privacy > location services > weathergift to enable locaiton services in this app.")
            }
        case .restricted:
            showAlert(title: "location services denied", message: "it may be that parental controls are restricting locaiton use in this app.")
        }
    }
    
//    func showAlert(title: String, message: String) {
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        
//        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//        alertController.addAction(defaultAction)
//        
//        present(alertController, animated: true, completion: nil)
//    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleLocationAuthorizationStatus(status: status)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if currentPage == 0 && self.view.window != nil {
            
            let geoCoder = CLGeocoder()
            
            currentLocation = locations.last
            
            let currentLat = "\(currentLocation.coordinate.latitude)"
            let currentLong = "\(currentLocation.coordinate.longitude)"
            
            print("coordinates are: " + currentLat + currentLong)
            
            
            var place = ""
            
            geoCoder.reverseGeocodeLocation(currentLocation, completionHandler: {placemarks,
                error in
                if placemarks != nil {
                    let placemark = placemarks!.last
                    place = (placemark?.name!)!
                } else {
                    print("Error retrieving place. Error code: \(error)")
                    place = "Parts Unknown"
                }
                print(place)
                self.locationsArray[0].name = place
                self.locationsArray[0].coordinates = currentLat + "," + currentLong
                self.locationsArray[0].getWeather {
                    self.updateUserInterface()
                }
            })
        }
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location - error code \(error)")
    }
}
extension DetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationsArray[currentPage].dailyForecastArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayWeatherCell") as! DayWeatherCell
        cell.configureTableCell(dialyForecast: self.locationsArray[currentPage].dailyForecastArray[indexPath.row], timeZone: self.locationsArray[currentPage].timeZone)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension DetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locationsArray[currentPage].hourlyForecastArray.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hourlyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyCell", for: indexPath) as! HourlyWeatherCell
        hourlyCell.configureCollectionCell(hourlyForecast: self.locationsArray[currentPage].hourlyForecastArray[indexPath.row], timeZone: self.locationsArray[currentPage].timeZone)
        return hourlyCell
    }
    
    
}

//extension DetailVC {
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if segue.identifier == "ToBottom" {
//            
//            let bottomsVC = segue.destination as! BottomsVC
//            bottomsVC.temperature = temperatureLabel.text!
//            
//        }
//    }
//}



extension DetailVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toShoes" {

           let shoesVC = segue.destination as! ShoesVC
            shoesVC.temperature = locationsArray[currentPage].currentTemp

        } else if segue.identifier == "toAccessories" {
            
            let actualAccessoriesVC = segue.destination as! ActualAccessoriesVC
            actualAccessoriesVC.temperature =  locationsArray[currentPage].currentTemp
                //.hourlyForecastArray[2].hourlyPrecipProb
            
        } else if segue.identifier == "toBottoms" {
            
            let bottomsVC = segue.destination as! BottomsVC
            bottomsVC.temperature = locationsArray[currentPage].currentTemp
    
        } else if segue.identifier == "toTops" {
            
            let topsVC = segue.destination as! TopsVC
            topsVC.temperature = locationsArray[currentPage].currentTemp
        
        }
    }
}




