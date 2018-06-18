//
//  PaymentMethod.swift
//  Driveo
//
//  Created by Admin on 6/6/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation


public struct PaymentMethods: Codable {
    let paymentMethods: [PaymentMethod]?
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case paymentMethods = "Payment_methods"
        case message
    }
}
public struct PaymentMethod {
    var id: Int?
    var name: String?
    var image: Image?
    var isSelected: Bool = false
    init() {}
}


// MARK : Encoding and Decoding
extension PaymentMethod : Codable  {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        image = try container.decode(Image.self, forKey: .image)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(image, forKey: .image)
    }
}


