//
//  ViewController.swift
//  Wevva
//
//  Created by Hugh Jarvis on 12/12/2019.
//  Copyright © 2019 Hugh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var weatherView: UITableView!
    @IBOutlet weak var weatherPicker: UIPickerView!
    
    let weatherService = WeatherService()
    let weatherChecker = WeatherChecker()
    let coord = Coord(latitude: 40.42, longitude: -3.69)
    
    struct TempRange {
           let upper: Float
           let lower: Float
           let description: String
       }
       
    let minusTenOrColder = TempRange(upper: 263.99, lower: 0, description: "-10C or colder")
    let minusNineToMinusFive = TempRange(upper: 268.99, lower: 264.00, description: "-9C to -5C")
    let minusFourToZero = TempRange(upper: 273.99, lower: 269.00, description: "-4C to 0C")
    let oneToFive = TempRange(upper: 278.99, lower: 274.00, description: "1C to 5C")
    let sixToTen = TempRange(upper: 283.99, lower: 279.00, description: "6C to 10C")
    let elevenToFifteen = TempRange(upper: 288.99, lower: 284.00, description: "11C to 15C")
    let sixteenToTwenty = TempRange(upper: 293.99, lower: 289.00, description: "16C to 20C")
    let twentyOneToTwentyFive = TempRange(upper: 298.99, lower: 294.00, description: "21C to 25C")
    let twentySixToThirty = TempRange(upper: 303.99, lower: 299.00, description: "26C to 30C")
    let thirtyOneToThirtyFive = TempRange(upper: 308.99, lower: 304.00, description: "31C to 35C")
    let thirtySixOrHotter = TempRange(upper: 313.99, lower: 309.00, description: "36C or hotter")
         
    var temperatureRanges: [TempRange] = []
    
    
    let clearSky = Weather(description: "clear sky", icon: "01d")
    let lightCloud = Weather(description: "light cloud", icon: "02d")
    let scatteredCloud = Weather(description: "scattered cloud", icon: "03d")
    let heavyCloud = Weather(description: "heavy cloud", icon: "04d")
    let showers = Weather(description: "showers", icon: "09d")
    let rain = Weather(description: "rain", icon: "10d")
    let thunder = Weather(description: "thunder", icon: "11d")
    let snow = Weather(description: "snow", icon: "13d")
    let fog = Weather(description: "fog", icon: "50d")
      
    var weatherValues: [Weather] = []
      
    var requestedWeather: Weather = Weather(description: "clear sky", icon: "01d")
    var requestedTemperatureRange: TempRange = TempRange(upper: 293, lower: 303, description: "20C to 30C")
    
        var fetchedLocations: [Location] = []{
                didSet {
                    DispatchQueue.main.async {
                        self.weatherView.reloadData()
                    }
                }
            }
    
    
    
        var weatherMatchLocations: [Location] = []
    
    
    
      //  var latitude: Double = 0
      //  var longitude: Double = 0
       
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherPicker.dataSource = self
        weatherPicker.delegate = self
        weatherView.dataSource = self
        weatherView.delegate = self
        
        temperatureRanges = [minusTenOrColder, minusNineToMinusFive, minusFourToZero, oneToFive, sixToTen, elevenToFifteen, sixteenToTwenty, twentyOneToTwentyFive, twentySixToThirty, thirtyOneToThirtyFive, thirtySixOrHotter]
        
        weatherValues = [clearSky, lightCloud, scatteredCloud, heavyCloud, showers, rain, thunder, snow, fog]
        
        requestedWeather = clearSky
        requestedTemperatureRange = twentySixToThirty
    }

    
    
    @IBAction func whereToGoTapped(_ sender: Any) {
        print("tell me where to go button clicked")
        self.weatherService.getLocations(coord: self.coord, locationsCompletionHandler: { locations in
            if let locations = locations {
                DispatchQueue.main.async {
                    self.fetchedLocations = locations
                    print(self.fetchedLocations)
                   
                    
//                    self.weatherMatchLocations = self.weatherChecker.getLocationsWithRequestedWeather(locations: self.fetchedLocations, requestedHighTemperature: self.requestedTemperatureRange.upper, requestedLowTemperature: self.requestedTemperatureRange.lower, requestedIcon: self.requestedWeather.icon)
//
//                    if self.weatherMatchLocations.count >= 1 {
//                        //load into table view
//                    }
//  if matchedLocations.count >= 1 then load these into table view
                    // else get weather in further flung locations
                    
                }
            }
        })
    }
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.fetchedLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let location = self.fetchedLocations[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherLocationCell") as! WeatherLocationCell
        
        cell.setLocation(location: location)
        
        return cell
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return weatherValues.count
        } else {
            return temperatureRanges.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        60.00
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return weatherValues[row].description
        } else {
            return temperatureRanges[row].description
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let weatherPickerView = UIView(frame: CGRect(x: 0, y: 0, width: Double(pickerView.bounds.width/2.2), height: 60))
        
        let iconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        let weatherPickerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: Double(weatherPickerView.bounds.width), height: 20))
        
        
        if component == 0 {
            iconView.image = UIImage(imageLiteralResourceName: weatherValues[row].icon)
            weatherPickerLabel.text = weatherValues[row].description
            weatherPickerLabel.textAlignment = .center
            weatherPickerView.addSubview(iconView)
            weatherPickerView.addSubview(weatherPickerLabel)
            return weatherPickerView
        } else {
            weatherPickerLabel.text = temperatureRanges[row].description
            weatherPickerLabel.textAlignment = .center
            weatherPickerView.addSubview(weatherPickerLabel)
            return weatherPickerView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            requestedWeather = weatherValues[row]
        } else {
            requestedTemperatureRange = temperatureRanges[row]
        }
    }
    
}
}
