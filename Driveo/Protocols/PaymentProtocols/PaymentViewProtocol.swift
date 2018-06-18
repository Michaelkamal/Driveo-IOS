//
//  PaymentProtocol.swift
//  Driveo
//
//  Created by Admin on 6/6/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
protocol PaymentViewProtocol:GenericProtocol {
    func updateTableViewData(withArray array:[PaymentMethod])->Void
    func showLoading()
    func dismissLoading()
}
