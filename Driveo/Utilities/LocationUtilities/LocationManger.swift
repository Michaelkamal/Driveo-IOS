//
//  HomeViewController.swift
//  Maddar
//
//  Created by Admin on 5/23/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import GoogleMaps

class LocationManager : NSObject,CLLocationManagerDelegate{
    
    private var locationMgr:CLLocationManager!
    private var delegate:LocationManagerProtocol?
    private var locationReturn : ((CLLocation?)->Void)?
    private var isFirstTime:Bool = true
    
    static internal func sharedInstance (withDelagate delagate:LocationManagerProtocol) ->(LocationManager)
    {
        struct Singleton {
            static let instance = LocationManager();
        }
        Singleton.instance.delegate=delagate
        return Singleton.instance
        
    }
    private override init(){
        super.init()
        locationMgr = CLLocationManager()
        locationMgr.delegate=self
    }
    
    // mark: When change authorization
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(isFirstTime){
            isFirstTime=false
            return
        }
        switch status {
        case .notDetermined,.restricted, .denied:
            delegate?.goToSettings()
        case .authorizedAlways,.authorizedWhenInUse:
            locationMgr.startUpdatingLocation()
        }
        }
    
    // mark: When location update
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location:CLLocation = locations.first{
                locationReturn?(location)
        }
        locationMgr.stopUpdatingLocation()
    }
    // mark: Call to update location
    
    private func enableLocationServices() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined,.restricted, .denied:
            locationMgr.requestAlwaysAuthorization()
        case .authorizedAlways,.authorizedWhenInUse:
            locationMgr.startUpdatingLocation()
        }
    }
    
    func getCurrentLocation(toMethod method:@escaping (CLLocation?)->Void)->(Void)
    {
        locationReturn=method
        self.enableLocationServices()
    }
    
    func getAddress(ofLocationCoordinates location:CLLocation,onSuccess:@escaping (String)->Void) -> Void
    {
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarksArray, error) in
            if let placemarksArray = placemarksArray{
            if (placemarksArray.count) > 0 {
                let placemark = placemarksArray.first
                var address:String=""
                if let street = placemark!.thoroughfare {address += street }
                if let number = placemark!.subThoroughfare {address += ", \(number)"}
                if let subLocality = placemark!.subLocality {address += ", \(subLocality)"}
                if let locality = placemark!.locality {address += ", \(locality)"}
                onSuccess(address != "" ? address : "Picked location")
            }
            }}
    }
    
}

