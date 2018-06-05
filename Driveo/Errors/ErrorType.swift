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
    case location = "This app is unusable if you don't authorize this app to use your location!"
    case parse = "Error parsing Json"
    case destinationError = "Destination can't be the source location"
    case incompleteData = "Please complete data"
    case invalidEmal = ""
    case invalidPhoneNumber = "w"
    case passwordLength = "e"
    case passwordNumberLetterError = "r"
    case confirmPassword = "t"
    
    }
