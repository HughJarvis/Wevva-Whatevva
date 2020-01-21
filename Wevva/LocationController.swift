
import Foundation
import CoreLocation
import UIKit


class LocationController:  NSObject {
    let locationManager = CLLocationManager()
    var userLocation: CLLocation?
    
    func getUserLocation() {
        
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
            }
        
        
        }
    
    }
