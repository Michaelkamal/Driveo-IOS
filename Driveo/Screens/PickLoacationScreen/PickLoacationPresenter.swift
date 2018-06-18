//
//  HomePresenter.swift
//  Map
//
//  Created by Admin on 5/29/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import CoreLocation
import GooglePlaces

class PickLoacationPresenter{
    
    
    private var selectedLocation:OrderLocation!
    
    private var userOrder:Order=Order.sharedInstance()
    
    private var carrier:Provider?
    private var pickUpDate:String?
    private var providersArray:[Provider]?
    
    private var viewDelagate:PickLocationViewProtocol!
    
    private let googlePlacesDal:GooglePlacesDAL = GooglePlacesDAL.sharedInstance()
    
    private lazy var locationManager:LocationManager=LocationManager.sharedInstance(withDelagate: controller)
    
    private var controller:UIViewController!
    
    init(withController controller:UIViewController) {
        self.controller=controller
        viewDelagate=controller as! PickLocationViewProtocol
        self.pickUpDate=userOrder.date
        if viewDelagate.isCurrentScreenSourcePickUp{
            if (userOrder.source != nil )
            {
               selectedLocation = userOrder.source
            }else{
                selectedLocation=OrderLocation()
            }
        }else
        {
            if (userOrder.destination != nil )
            {
                selectedLocation = userOrder.destination
            }else{
                selectedLocation=OrderLocation()
            }
        }
    }
    // set order date
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        
        // Apply date format
        let selectedDate: String = dateFormatter.string(from: sender.date)
        
        pickUpDate=selectedDate
        print("Selected value \(selectedDate)")
    }
    
    // get user current location
    func getCurrentLocation() {
        locationManager.getCurrentLocation { (location) in
            if let locationFound = location{
                self.locationManager.getAddress(ofLocationCoordinates: locationFound, onSuccess:{(address) in
                    self.viewDelagate.placeMarker(onLocation: locationFound,withTitle: address,andImage: #imageLiteral(resourceName: "ic_myself"))
                    self.selectedLocation.coordinates=locationFound
                    self.selectedLocation.address=address
                })
                
            }}
    }
    
    // create order and move to destination (OR) set destination and move to create order
    func moveForward() {
        if viewDelagate.isCurrentScreenSourcePickUp
        {
            if selectedLocation.isComplete(),pickUpDate != nil,carrier != nil
            {
                    userOrder.source=selectedLocation
                    userOrder.date=pickUpDate
                    userOrder.provider=carrier
                    viewDelagate.presentToNextScreen()
            }else
            {
                viewDelagate.showAlert(ofError: .incompleteData)
            }
        }else
        {
            if selectedLocation.isComplete()
            {
                if userOrder.source?.coordinates!.coordinate.longitude != selectedLocation.coordinates!.coordinate.longitude, userOrder.source?.coordinates!.coordinate.latitude != selectedLocation.coordinates!.coordinate.latitude
                {
                    userOrder.destination=selectedLocation
                    viewDelagate.presentToNextScreen()
                }else{
                    viewDelagate.showAlert(ofError: .destinationError)
                }
            }else
            {
                viewDelagate.showAlert(ofError: .incompleteData)
            }
        }
        
    }
    
    // Select carrier
    func didSelectCarrier(selectedCarrier carrier:Provider)->Void {
        viewDelagate.displaySelectedCarrier(withLogoUrl:carrier.image!.url!)
        self.carrier=carrier
    }
    
    
    func getCarriers(){
        if let carriers = providersArray{
             viewDelagate.updateCarrierArray(withCarriers: carriers)
        }else{
            let defaults = UserDefaults.standard
            if let token = defaults.string(forKey: "auth_token") {
            NetworkDAL.sharedInstance().processReq(withBaseUrl: ApiBaseUrl.mainApi, andUrlSuffix: SuffixUrl.providers.rawValue, withParser: { (JSON) -> [Any] in
                var res:[Any]=[]
                if let providers = try? JSONDecoder().decode(Providers.self, from: JSON.rawData()) {
                    if let providersArray = providers.providers{
                    res += providersArray as [Any]
                    }
                }
                else
                {
                    self.viewDelagate.showAlert(ofError: ErrorType.parse)
                }
                return res
            },andHeaders:["Authorization":token],
                onSuccess: { (providers) in
                self.viewDelagate.updateCarrierArray(withCarriers: providers as! [Provider])
                self.providersArray=providers as? [Provider]
            }, onFailure: { err  in
                print(err)
                self.viewDelagate.showAlert(ofError: ErrorType.internet)
            })
            }
        }
    }
}

// mark : places auto complete extention
extension PickLoacationPresenter {
    
    func searchForPlace(withName name:String)->Void {
        googlePlacesDal.searchForPlace(withName: name, onSuccess: viewDelagate.renderPlaces, onFailure: viewDelagate.showAlert)
    }
    
    func didSelectplace(selectedPlace place:PlaceDPItem,_ onSuccess:()->Void)->Void {
        guard let placeID=place.id else{
            return
        }
        googlePlacesDal.getPlaceDetails(withID: placeID, onSuccess: { (placeDetails) in
            let coordinates=CLLocation(latitude: placeDetails.coordinate.latitude,longitude: placeDetails.coordinate.longitude)
            self.viewDelagate.placeMarker(onLocation: coordinates,withTitle: placeDetails.formattedAddress!,andImage: #imageLiteral(resourceName: "ic_destination_b"))
            self.selectedLocation.coordinates=coordinates
            self.selectedLocation.address=placeDetails.formattedAddress
            self.viewDelagate.clearSearchText()
        }, onFailure: viewDelagate.showAlert)
    }
}
