//
//  ErrorType.swift
//  Map
//
//  Created by Admin on 5/29/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
enum ErrorType:String,Error{
    case internet = "Check your internet connection"
    case location = "Allow app to use location in order to continue"
    case parse = "Error parsing Json"
}
