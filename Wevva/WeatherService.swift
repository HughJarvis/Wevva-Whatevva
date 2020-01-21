//
//  WeatherService.swift
//  Wevva
//
//  Created by Hugh Jarvis on 12/12/2019.
//  Copyright © 2019 Hugh. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherService {
    
    
    func getLocations(userLocation: CLLocation?, locationsCompletionHandler: @escaping ([Location]?) -> Void) -> Void {
        
//        var left = 0.0
//        var bottom = 0.0
//        var right = 0.0
//        var top = 0.0
        var latitude = 0.0
        var longitude = 0.0
        
        if let userLocation = userLocation {
            latitude = Darwin.round(userLocation.coordinate.latitude)
            print(latitude)
            longitude = Darwin.round(userLocation.coordinate.longitude)
            print(longitude)
//            left = longitude - 2.50
//            bottom = latitude - 2.50
//            right = longitude + 2.50
//            top = latitude + 2.50
        }
        
// for alternative API call that defines area to search in
//        let url = URL(string: "https://api.openweathermap.org/data/2.5/box/city?bbox=\(left),\(bottom),\(right),\(top),10&APPID=eb85809fe35a919d1b811ce9c19bc453")!
//

        let url = URL(string: "https://api.openweathermap.org/data/2.5/find?lat=\(latitude)&lon=\(longitude)&cnt=10&APPID=eb85809fe35a919d1b811ce9c19bc453")!
        
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }

            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            let decoder = JSONDecoder()
            
            do {
                let weatherInfo = try! decoder.decode(WeatherInfo.self, from: data!)
                locationsCompletionHandler(weatherInfo.list)
            }
            
        })
        dataTask.resume()
    }
}



