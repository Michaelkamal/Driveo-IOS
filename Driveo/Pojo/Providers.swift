//
//  Providers.swift
//  Driveo
//
//  Created by Admin on 6/6/18.
//  Copyright © 2018 ITI. All rights reserved.
//


// To parse the JSON, add this file to your project and do:
//
//   let providers = try? JSONDecoder().decode(Providers.self, from: jsonData)
//

import Foundation
import Alamofire

public struct Providers: Codable {
    let providers: [Provider]?
}

public struct Provider: Codable {
    let id: Int?
    let name: String?
    let image: Image?
    let rating: String?
}

public struct Image: Codable {
    let url: String?
}

