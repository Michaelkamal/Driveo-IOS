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
    
    public var userOrder:Order?
    
    private var carrier:String?
    private var pickUpDate:String?
    
    
    private var viewDelagate:PickLocationProtocol!
    
    private let googlePlacesDal:GooglePlacesDAL = GooglePlacesDAL.sharedInstance()
    
    private lazy var locationManager:LocationManager=LocationManager.sharedInstance(withDelagate: controller)
    
    private var controller:UIViewController!
    
    init(withController controller:UIViewController,andOrder order:Order?=nil) {
        self.controller=controller
        self.userOrder=order
        viewDelagate=controller as! PickLocationProtocol
        
        if let userOrder = self.userOrder {
            self.pickUpDate=userOrder.date
            if viewDelagate.isCurrentScreenSourcePickUp{
               selectedLocation = userOrder.source
            }else{
            if let destination = userOrder.destination
            {
                selectedLocation = destination
            }
            else
            {
                selectedLocation=OrderLocation(locationType: LocationType.destination)
            }
            }
        }
        else{
            if viewDelagate.isCurrentScreenSourcePickUp {
                selectedLocation=OrderLocation(locationType: LocationType.source)
            }
        }
    }
    // set order date
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        
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
                if let userOrder = userOrder {
                    userOrder.source=selectedLocation
                    userOrder.date=pickUpDate
                    if let carrier=carrier{userOrder.carrier=carrier}
                }else{
                    userOrder=Order(withSource: selectedLocation,byCarrier: carrier!, onDate: pickUpDate!)
                }
                viewDelagate.presentToNextScreen(withOrder:userOrder!)
            }else
            {
                viewDelagate.showAlert(ofError: .incompleteData)
            }
        }else
        {
            if selectedLocation.isComplete(),let userOrder=userOrder
            {
                if userOrder.source.coordinates!.coordinate.longitude != selectedLocation.coordinates!.coordinate.longitude, userOrder.source.coordinates!.coordinate.latitude != selectedLocation.coordinates!.coordinate.latitude
                {
                    userOrder.destination=selectedLocation
                    viewDelagate.presentToNextScreen(withOrder:userOrder)
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
    func didSelectCarrier(selectedCarrier carrier:CarrierDPItem)->Void {
        viewDelagate.displaySelectedCarrier(withLogo:carrier.carrierLogo!)
        self.carrier=carrier.carrierName
    }
    
    
    func getCarriers()->[CarrierDPItem]{
        return [CarrierDPItem(CarrierName: "DHL",andRating: "4.4", image: #imageLiteral(resourceName: "ic_dhl")),
                CarrierDPItem(CarrierName: "TNT",andRating: "4.5", image: #imageLiteral(resourceName: "ic_tnt")),
                CarrierDPItem(CarrierName: "FEDEX",andRating: "5.0", image: #imageLiteral(resourceName: "ic_fedex"))]
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
