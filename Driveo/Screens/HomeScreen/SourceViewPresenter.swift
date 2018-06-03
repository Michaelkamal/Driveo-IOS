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

class SourceViewPresenter{
    
    
    private var sourceLocation:OrderLocation!
    private var carrier:String?
    private var pickUpDate:String?
    
    private var view:UIViewController!
    
    private var viewDelagate:SourceViewProtocol!
    
    private let googlePlacesDal:GooglePlacesDAL = GooglePlacesDAL.sharedInstance()
    
    private lazy var locationManager:LocationManager=LocationManager.sharedInstance(withDelagate: controller)
    
    private var controller:UIViewController!
    
    init(withController controller:UIViewController ) {
        self.controller=controller
        viewDelagate=controller as! SourceViewProtocol
        sourceLocation=OrderLocation(locationType: LocationType.source)
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
                    self.sourceLocation.coordinates=locationFound
                    self.sourceLocation.address=address
                })
              
            }}
    }
    
    // create order
    func createOrder() {
       if sourceLocation.isComplete(),pickUpDate != nil,carrier != nil
       {
        let order:Order=Order(withSource: sourceLocation,byCarrier: carrier!, onDate: pickUpDate!)
        viewDelagate.presentToNextScreen(withOrder:order)
        }else
       {
        viewDelagate.showAlert(ofError: .incompleteData)
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
extension SourceViewPresenter {
    
    func searchForPlace(withName name:String)->Void {
        googlePlacesDal.searchForPlace(withName: name, onSuccess: viewDelagate.renderPlaces, onFailure: viewDelagate.showAlert)
    }
    
    func didSelectplace(selectedPlace place:PlaceDPItem,_ onSuccess:()->Void)->Void {
        print(place)
        guard let placeID=place.id else{
            return
        }
        googlePlacesDal.getPlaceDetails(withID: placeID, onSuccess: { (placeDetails) in
            let coordinates=CLLocation(latitude: placeDetails.coordinate.latitude,longitude: placeDetails.coordinate.longitude)
            self.viewDelagate.placeMarker(onLocation: coordinates,withTitle: placeDetails.formattedAddress!,andImage: #imageLiteral(resourceName: "ic_destination_b"))
            self.sourceLocation.coordinates=coordinates
            self.sourceLocation.address=placeDetails.formattedAddress
            self.viewDelagate.clearSearchText()
        }, onFailure: viewDelagate.showAlert)
}
}
