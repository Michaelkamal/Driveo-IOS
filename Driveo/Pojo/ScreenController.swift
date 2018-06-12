//
//  ScreenStoryBoardController.swift
//  Driveo
//
//  Created by Admin on 6/3/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
import UIKit
enum ScreenController:String{
    case main="UINavigationController"
    case sourceScreen = "PickLoacationViewController"
    case destinationScreen = "PickLoacationViewController "
    case createOrderScreen = "CreateOrderViewController"
    case paymentScreen = "PaymentViewController"
    case navigationDrawerScreen = "NavigationDrawerViewController"
    
    func storyBoardName() -> String {
        var storyBoardName:String
        switch self {
        case .main:
            storyBoardName="Main"
        case .sourceScreen:
            storyBoardName="SourceScreen"
        case .destinationScreen:
            storyBoardName="DestinationScreen"
        case .createOrderScreen :
            storyBoardName="CreateOrderScreen"
        case .paymentScreen:
            storyBoardName="PaymentScreen"
        case .navigationDrawerScreen:
            storyBoardName="NavigationDrawerScreen"
        
        }
        return storyBoardName
    }
}
