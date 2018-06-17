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
    case sourceScreen = "UINavigationController"
    case destinationScreen = "PickLoacationViewController"
    case createOrderScreen = "CreateOrderViewController"
    case paymentScreen = "PaymentViewController"
    case navigationDrawerScreen = "NavigationDrawerViewController"
    case createRequestScreen = "CreateRequestView"
    
    func storyBoardName() -> String {
        var storyBoardName:String
        switch self {
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
        case .createRequestScreen:
            storyBoardName="CreateRequest"
        }
        return storyBoardName
    }
}
