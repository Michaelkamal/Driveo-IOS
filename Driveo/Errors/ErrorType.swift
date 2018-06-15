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
    case invalidEmail = "Invalid Email"
    case invalidPhoneNumber = "This is not a valid phone number"
    case passwordLength = "Password length should between 6-12"
    case passwordNumberLetterError = "password must contain letter & number"
    case confirmPassword = "password doesn't match"
    case pinCodeError = "code not valid"
    case errorTitle = "Error"
    }
