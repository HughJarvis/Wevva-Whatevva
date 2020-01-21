//
//  ViewController.swift
//  Wevva
//
//  Created by Hugh Jarvis on 12/12/2019.
//  Copyright © 2019 Hugh. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var weatherTableView: UITableView!
    @IBOutlet weak var weatherPicker: UIPickerView!
    @IBOutlet weak var TellMeWhereToGo: UIButton!
    
    let weatherService = WeatherService()
    let weatherChecker = WeatherChecker()
    var locationController = LocationController()
    
    
    var fetchedLocations: [Location] = []
         
    
    var weatherPickerDataSource = WeatherPickerDataSource()
   
       
    var userLocation: CLLocation?
    
//    var testLocation = Coord(latitude: 56.29, longitude: 2.97)
        

    
        

    override func viewDidLoad() {
        super.viewDidLoad()
      //  TellMeWhereToGo.isEnabled = false
        weatherPicker.dataSource = weatherPickerDataSource
        weatherPicker.delegate = weatherPickerDataSource
        
        weatherTableView.dataSource = self
        weatherTableView.delegate = self
        
        weatherPickerDataSource.createTemperatureRanges()
        weatherPickerDataSource.createWeatherValues()
        
        
//        locationController.getUserLocation()
//        print(locationController.userLocation)
        
        
         DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            self.userLocation = self.locationController.locationManager.location
        }
       
        
        
        
        
//        if let userLocation = userLocation {
//            self.userLocation = userLocation
//            print("and this knows location is\(self.userLocation)")
//            TellMeWhereToGo.isEnabled = true
//        }
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let matchedWeatherViewcontroller = segue.destination as! MatchedWeatherViewController
//        if let weatherViewDataSource.fetchedLocations = fetchedlocations {
//            matchedWeatherViewController.weatherlocations = fetchedLocations
//        }
//    }
    
    
    /*
       // MARK: - Navigation

       // In a storyboard-based application, you will often want to do a little preparation before navigation
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           // Get the new view controller using segue.destination.
           // Pass the selected object to the new view controller.
       }
       */

    
    @IBAction func whereToGoWasTapped(_ sender: Any) {
        print("Tell me where to go button tapped")
        weatherService.getLocations(locationsCompletionHandler: {locations in
            if let locations = locations {
                DispatchQueue.main.async {
                    self.fetchedLocations = locations
                    self.weatherTableView.reloadData()
                }
            }
        })
    }
    
    
//    @IBAction func whereToGoTapped(_ sender: Any) {
//        print("tell me where to go button clicked")
//        print("user location is \(userLocation)")
//        self.weatherService.getLocations(locationsCompletionHandler: { locations in
//            if let locations = locations {
//                DispatchQueue.main.async {
//                    self.fetchedLocations = locations
//                    print(self.fetchedLocations)
                
                    
//                    self.weatherMatchLocations = self.weatherChecker.getLocationsWithRequestedWeather(locations: self.fetchedLocations, requestedHighTemperature: self.requestedTemperatureRange.upper, requestedLowTemperature: self.requestedTemperatureRange.lower, requestedIcon: self.requestedWeather.icon)
//
//                    if self.weatherMatchLocations.count >= 1 {
//                        //load into table view
//                    }
//  if matchedLocations.count >= 1 then load these into table view
                    // else get weather in further flung locations
                    
//                }
//            }
//        })
//    }
//}
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherLocationCell") as! WeatherLocationCell
        let location = fetchedLocations[indexPath.row]
        cell.setLocation(location: location)
        return cell
    }
  
}
