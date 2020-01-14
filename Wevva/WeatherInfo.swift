//
//  WeatherInfo.swift
//  Wevva
//
//  Created by Hugh Jarvis on 22/12/2019.
//  Copyright © 2019 Hugh. All rights reserved.
//

import Foundation

struct WeatherInfo: Codable {
    let list: [Location]
}

struct Location: Codable {
    let name: String
    let coord: Coord
    let main: Main
    let weather: [Weather]
}

struct Coord: Codable {
    let latitude: Float
    let longitude: Float
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
}
    
struct Main: Codable {
    let temperature: Float
        
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
    }
}
    
struct Weather: Codable {
    let description: String
    let icon: String
}

