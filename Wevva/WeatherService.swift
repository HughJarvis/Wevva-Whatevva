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
    
    
    func getLocations(location: CLLocation, locationsCompletionHandler: @escaping ([Location]?) -> Void) -> Void {
        
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/find?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&cnt=20&APPID=eb85809fe35a919d1b811ce9c19bc453")!
        
        
        
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
                
                
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
            
        })
        dataTask.resume()
    }
}
