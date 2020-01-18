
import Foundation
import CoreLocation
import UIKit


class LocationController:  NSObject {
    let locationManager = CLLocationManager()
    var userLocation = CLLocation()
    
    
    func getUserLocation() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
            }
        }
    
    }

extension LocationController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("ERROR!! locationManager didFailWithError: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations[0]
        
        print("user location is \(userLocation)")
    }
    
    
    
}
