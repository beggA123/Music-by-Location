//
//  LocationHandler.swift
//  Music by Location
//
//  Created by Begg, Alistair (AMM) on 02/03/2022.
//

import Foundation
import CoreLocation

class LocationHandler: NSObject, CLLocationManagerDelegate, ObservableObject {
    let manager = CLLocationManager()
    let geocoder = CLGeocoder()
    @Published var lastKnownLocation: String = ""
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestAuthorisation() {
        manager.requestWhenInUseAuthorization()
    }
    
    func requestLocation() {
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let firstLocation = locations.first {
            geocoder.reverseGeocodeLocation(firstLocation, completionHandler: { (placemarks, error) in
                if error != nil {
                    self.lastKnownLocation = "Could not perform lookup of coordinates"
                } else {
                    if let firstPlacemark = placemarks?[0] {
                        self.lastKnownLocation = """
                                                \(firstPlacemark.country ?? "Could not find country")
                                                \(firstPlacemark.administrativeArea ?? "Could not find administrative area")
                                                \(firstPlacemark.region ?? "Could not find region")
                                                \(firstPlacemark.locality ?? "Could not find locality")
                                                \(firstPlacemark.postalCode ?? "Could not find postal code")
                                                """
                    }
                }
            })
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        lastKnownLocation = "error finding location"
    }
}
