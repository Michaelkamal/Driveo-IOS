//
//  StringExtension.swift
//  NewTrial
//
//  Created by Admin on 5/23/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

extension String {
    enum regexes:String {
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case password = "^(?=.*?[a-z])(?=.*?[0-9]).{6,12}$"
    }
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    func validate(regex: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
    
    
}
