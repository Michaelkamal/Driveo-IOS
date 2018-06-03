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
    case sourceScreen = "PickLoacationViewController"
    case destinationScreen = "PickLoacationViewController "
    
    func storyBoardName() -> String {
        var storyBoardName:String
        switch self {
        case .sourceScreen:
            storyBoardName="SourceScreen"
        case .destinationScreen:
            storyBoardName="DestinationScreen"
        }
        return storyBoardName
    }
}
