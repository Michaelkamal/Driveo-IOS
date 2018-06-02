//
//  UIDatePicker.swift
//  Map
//
//  Created by Admin on 5/31/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import UIKit
extension UIDatePicker
{
    /// set the date picker values and set min/max
    /// - parameter date: Date to set the picker to
    /// - parameter unit: (years, days, months, hours, minutes...)
    /// - parameter deltaMinimum: minimum date delta in units
    /// - parameter deltaMaximum: maximum date delta in units
    /// - parameter animated: Whether or not to use animation for setting picker
    func setDate(_ date:Date, unit:NSCalendar.Unit, deltaMinimum:Int, deltaMaximum:Int, animated:Bool)
    {
        setDate(date, animated: animated)
        
        setMinMax(unit: unit, deltaMinimum: deltaMinimum, deltaMaximum: deltaMaximum)
    }
    
    /// set the min/max for the date picker (uses the pickers current date)
    /// - parameter unit: (years, days, months, hours, minutes...)
    /// - parameter deltaMinimum: minimum date delta in units
    /// - parameter deltaMaximum: maximum date delta in units
    func setMinMax(unit:NSCalendar.Unit, deltaMinimum:Int, deltaMaximum:Int)
    {
        if let gregorian = NSCalendar(calendarIdentifier:.gregorian)
        {
            if let minDate = gregorian.date(byAdding: unit, value: deltaMinimum, to: self.date)
            {
                minimumDate = minDate
            }
            
            if let maxDate = gregorian.date(byAdding: unit, value: deltaMaximum, to: self.date)
            {
                maximumDate = maxDate
            }
        }
    }
}
