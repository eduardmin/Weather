//
//  LocationManager.swift
//  Weather
//
//  Created by Eduard Minasyan on 24.09.23.
//

import Foundation
import UIKit
import CoreLocation

struct LocationModel {
    var latitude: Double?
    var longitude: Double?
    var cityName: String?
    
    init(latitude: Double?, longitude: Double?, cityName: String?) {
        self.latitude = latitude
        self.longitude = longitude
        self.cityName = cityName
    }
    
    init(with dict: [String: Any]) {
        latitude = dict["latitude"] as? Double
        longitude = dict["longitude"] as? Double
        cityName = dict["cityName"] as? String
    }
    
    func getDictionary() -> [String: Any] {
        var dict = [String: Any]()
        dict["latitude"] = latitude
        dict["longitude"] = latitude
        dict["cityName"] = cityName
        return dict
    }
}


class LocationManager: NSObject {
    private var locationManager: CLLocationManager =  CLLocationManager()
    private var location: CLLocation? {
        didSet {
            if let location = location {
                location.fetchCity { city, error in
                    guard let city = city, error == nil else { return }
                    self.locationModel = LocationModel(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, cityName: city)
                }
            }
        }
    }
    @Published var locationModel: LocationModel?
    @Published var error: Error?
    override init() {
        super.init()
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.distanceFilter = 0.1
        locationManager.delegate = self
    }
}

//MARK:- CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.error = error
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        self.location = location
        stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            break
        case .restricted:
            self.error = NSError()
        case .denied:
            self.error = NSError()
        default:
            break
        }
        
    }
}

//MARK:- Public func
extension LocationManager {
    func startUpdatingLocation() {
        self.locationManager.startUpdatingLocation()
        self.locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func stopUpdatingLocation() {
        self.locationManager.stopUpdatingLocation()
    }
    
    func requestForAutorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationServicesEnabled() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch locationManager.authorizationStatus {
            case .notDetermined, .restricted, .denied:
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                return true
            @unknown default:
                return false
            }
        } else {
            return false
        }
    }
}

extension CLLocation {
    func fetchCity(completion: @escaping (_ city: String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self, preferredLocale: Locale(identifier: "en-EN")){
            completion($0?.first?.locality, $1)
        }
    }
}
