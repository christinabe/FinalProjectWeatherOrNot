//
//  DayWeatherCell.swift
//  WeatherGift
//
//  Created by CSOM on 4/3/17.
//  Copyright © 2017 CSOM. All rights reserved.
//

import UIKit

class DayWeatherCell: UITableViewCell {

    
    @IBOutlet weak var cellIcon: UIImageView!
    
    @IBOutlet weak var cellWeekday: UILabel!
    
    @IBOutlet weak var cellMaxTemp: UILabel!
    
    @IBOutlet weak var cellMinTemp: UILabel!
    
    @IBOutlet weak var cellSummary: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureTableCell(dialyForecast: WeatherLocation.DailyForecast, timeZone: String) {
        cellMaxTemp.text = String(format: "%2.f", dialyForecast.dailyMaxTemp) + "°"
        cellMinTemp.text = String(format: "%2.f", dialyForecast.dailyMinTemp) + "°"
        cellSummary.text = dialyForecast.dailySummary
        cellIcon.image = UIImage(named: dialyForecast.dailyIcon)
        let usableDate = Date(timeIntervalSince1970: dialyForecast.dailyDate)
        let dailyTimeZone = TimeZone(identifier: timeZone)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.timeZone = dailyTimeZone
        let weekDay = dateFormatter.string(from: usableDate)
        cellWeekday.text = weekDay
    }

}
