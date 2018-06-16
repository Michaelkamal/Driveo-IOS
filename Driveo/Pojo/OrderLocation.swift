//
//  SelectedPlace.swift
//  Map
//
//  Created by Admin on 6/1/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import CoreLocation

struct OrderLocation {
    var address : String?
    var coordinates: CLLocation?
    
    init(withCoordinates coordinates:CLLocation?=nil,andAddress address:String?=nil) {
        self.coordinates=coordinates
        self.address=address
    }
    func isComplete()->Bool{
    if address != nil , coordinates != nil
        {
            return true
        }
        return false
    }
}
// MARK : Encoding and Decoding
extension OrderLocation : Codable  {
    enum CodingKeys: String, CodingKey {
        case address
        case latitude
        case longitude
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        address = try container.decode(String.self, forKey: .address)
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        coordinates = CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(address, forKey: .address)
        try container.encode(coordinates?.coordinate.latitude, forKey: .latitude)
        try container.encode(coordinates?.coordinate.latitude, forKey: .longitude)
    }
}
