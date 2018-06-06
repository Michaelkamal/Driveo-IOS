//
//  PaymentMethod.swift
//  Driveo
//
//  Created by Admin on 6/6/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation

public struct PaymentMethods: Codable {
    let methods: [PaymentMethod]?
}

public struct PaymentMethod: Codable {
    let id: Int?
    let name: String?
    let image: Image?
    var isSelected: Bool = false
    var isEnable: Bool = false
}

