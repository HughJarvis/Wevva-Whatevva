//
//  WeatherChecker.swift
//  Wevva
//
//  Created by Hugh Jarvis on 23/12/2019.
//  Copyright © 2019 Hugh. All rights reserved.
//

import Foundation

class WeatherChecker {
    
    func getLocationsWithRequestedWeather(locations: [Location], requestedHighTemperature: Float, requestedLowTemperature: Float, requestedIcon: String) -> [Location] {
        
        return locations.filter({$0.main.temperature <= requestedHighTemperature && $0.main.temperature >= requestedLowTemperature && $0.weather[0].icon == requestedIcon })
    }
    
 //   func spreadSearch(coord: Coord) -> [Coord] {
        //takes Coord of location with wrong weather, and returns array of 8 Coords 20 miles away at N, NE, E, SE etc
       // let coord1 = Coord(coord.latitude + 10, coord.longitude + 10)
        //
        
 //       return [coord1, coord2, coord3, coord4, coord5, coord6, coord7, coord8]
  //  }
    
}
