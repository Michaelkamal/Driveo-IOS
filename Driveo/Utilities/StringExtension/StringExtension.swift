//
//  StringExtension.swift
//  NewTrial
//
//  Created by Admin on 5/23/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
