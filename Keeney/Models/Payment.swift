    //
//  Payment.swift
//  Keeney
//
//  Created by Xie Liwei on 15/04/2018.
//  Copyright © 2018 Xie Liwei. All rights reserved.
//

import Foundation
import CoreLocation
class Payment {
    var amount: String
    var description: String
    var fromAccount: String
    var paymentType: String
    var paymentLocation: CLLocation?
    var paymentTime: String
    
    init(amount: String, description: String,fromAccount: String, paymentType: String, paymentLocation: CLLocation?, paymentTime: String) {
        self.amount = amount
        self.description = description
        self.fromAccount = fromAccount
        self.paymentType = paymentType
        self.paymentLocation = paymentLocation
        self.paymentTime = paymentTime
    }
}
