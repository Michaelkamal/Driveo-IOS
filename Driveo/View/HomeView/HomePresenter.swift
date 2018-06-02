//
//  HomePresenter.swift
//  Map
//
//  Created by Admin on 5/29/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import GooglePlacesSearchController
import CoreLocation
import GooglePlaces

class SourceViewPresenter{
    public var sourceLocation:OrderLocation!
    
    public var view:UIViewController!
    
    public var placeMarkerFunc : ((_ location:CLLocation,_ title:String,_ image:UIImage? )->Void)?
    
    public var clearTextFunc : (()->Void)?
    
    
    public var selectCarrierFunc : ((UIImage)->Void)?
    
    // Place auto complete client
    private lazy var placesClient : GMSPlacesClient = GMSPlacesClient()
    
    private lazy var locationManager:LocationManager=LocationManager.sharedInstance(withDelagate: controller)
    private var controller:UIViewController!
    init(withController controller:UIViewController ) {
        self.controller=controller
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
        
        print("Selected value \(selectedDate)")
    }
    
    // get user current location
    func getCurrentLocation() {
        locationManager.getCurrentLocation { (location) in
            if let locationFound = location{
                self.locationManager.getAddress(ofLocationCoordinates: locationFound, onSuccess:{(address) in
                    self.placeMarkerFunc?(locationFound,address,#imageLiteral(resourceName: "ic_myself"))
                    self.sourceLocation.coordinates=locationFound
                    self.sourceLocation.address=address
                })
              
            }}
    }
    
    // create order
    // TODO: validation and move to next screen
    func createOrder() {
    
    }
    
    // Select carrier
    // TODO: select carrier in order
    func didSelectCarrier(selectedCarrier carrier:CarrierDPItem)->Void {
        selectCarrierFunc?(carrier.carrierLogo!)
        print(carrier)
    }
    
    
    func getCarriers()->[CarrierDPItem]{
        return [CarrierDPItem(image: #imageLiteral(resourceName: "ic_dhl"),rating: "4.4"),
               CarrierDPItem(image: #imageLiteral(resourceName: "ic_tnt"),rating: "4.5"),
               CarrierDPItem(image: #imageLiteral(resourceName: "ic_fedex"),rating: "5.0")]
    }
}

// mark : places auto complete extention
extension SourceViewPresenter {
    
    func searchForPlace(withName name:String,andRenderFunction render:@escaping ([PlaceDPItem])->Void) {
        // TODO : if required criteria
        let filter = GMSAutocompleteFilter()
        filter.type = .noFilter
        
        placesClient.autocompleteQuery(name, bounds: nil, filter: filter, callback: {(results, error) -> Void in
            if let error = error {
                print("Autocomplete error \(error)")
                return
            }
            if let results = results {
                var placesArr:[PlaceDPItem]=[]
                for result in results {
                    let secondaryTxt = result.attributedSecondaryText?.string ?? ""
                    
                    placesArr += [PlaceDPItem(place: result.attributedPrimaryText.string,city: secondaryTxt,id: result.placeID)]
                }
                render(placesArr)
            }
        })
    }
    func didSelectplace(selectedPlace place:PlaceDPItem,_ onSuccess:()->Void)->Void {
        print(place)
        guard let placeID=place.id else{
            return
        }
        placesClient.lookUpPlaceID(placeID, callback: { (placeDetails, error ) in
            if let error = error {
                print("Autocomplete error \(error)")
                return
            }
            if let place=placeDetails{
                let coordinates=CLLocation(latitude: place.coordinate.latitude,longitude: place.coordinate.longitude)
                self.placeMarkerFunc?(coordinates,place.formattedAddress!,#imageLiteral(resourceName: "ic_destination_b"))
                self.sourceLocation.coordinates=coordinates
                self.sourceLocation.address=place.formattedAddress
                self.clearTextFunc?()
            }
        })
            onSuccess()
    }
}
