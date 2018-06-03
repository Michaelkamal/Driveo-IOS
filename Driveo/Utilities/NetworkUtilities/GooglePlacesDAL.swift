//
//  GooglePlacesDAL.swift
//  Driveo
//
//  Created by Admin on 6/3/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
import GooglePlaces

class GooglePlacesDAL{
    // Place auto complete client
    private lazy var placesClient : GMSPlacesClient = GMSPlacesClient()

    static internal func sharedInstance () ->(GooglePlacesDAL)
    {
        struct Singleton {
            static let instance = GooglePlacesDAL();
        }
        
        return Singleton.instance;
        
    }
    private init(){}
    
    func searchForPlace(withName name:String,onSuccess:@escaping ([PlaceDPItem])->Void
        ,onFailure:@escaping (ErrorType)->Void) {
        // TODO : if required criteria
        let filter = GMSAutocompleteFilter()
        filter.type = .noFilter
        
        placesClient.autocompleteQuery(name, bounds: nil, filter: filter, callback: {(results, error) -> Void in
            if let error = error {
                print("Autocomplete error \(error)")
                onFailure(.internet)
                return
            }
            if let results = results {
                var placesArr:[PlaceDPItem]=[]
                for result in results {
                    let secondaryTxt = result.attributedSecondaryText?.string ?? ""
                    
                    placesArr += [PlaceDPItem(place: result.attributedPrimaryText.string,city: secondaryTxt,id: result.placeID)]
                }
                onSuccess(placesArr)
            }
        })
    }
    func getPlaceDetails(withID id:String,onSuccess:@escaping (GMSPlace)->Void
        ,onFailure:@escaping (ErrorType)->Void)->Void {
 
        placesClient.lookUpPlaceID(id, callback: { (placeDetails, error ) in
            if let error = error {
                print("Autocomplete error \(error)")
                onFailure(.internet)
                return
            }
            if let placeDetails=placeDetails{
                onSuccess(placeDetails)
            }
        })
    }
}
