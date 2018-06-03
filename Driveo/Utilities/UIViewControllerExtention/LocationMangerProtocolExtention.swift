//
//  LocationMangerProtocolExtention.swift
//  Map
//
//  Created by Admin on 5/29/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController:LocationManagerProtocol
{
    func goToSettings() -> Void {
        let alert =  UIViewController.getAlertController(ofErrorType: .location, withTitle:"Need Authorization");
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
            let url = URL(string: UIApplicationOpenSettingsURLString)!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
