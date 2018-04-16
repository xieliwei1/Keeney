    //
//  Payment.swift
//  Keeney
//
//  Created by Xie Liwei on 15/04/2018.
//  Copyright © 2018 Xie Liwei. All rights reserved.
//

import Foundation
import CoreLocation
import CloudKit

class Payment {
    var amount: String
    var description: String
    var fromAccount: String
    var paymentType: String
    var paymentLocation: CLLocation?
    var paymentTime: String
    var paymentID: CKRecordID
    var isDeleted: String
    
    init(amount: String, description: String,fromAccount: String, paymentType: String, paymentLocation: CLLocation?, paymentTime: String, paymentID: CKRecordID, isDeleted: String) {
        self.amount = amount
        self.description = description
        self.fromAccount = fromAccount
        self.paymentType = paymentType
        self.paymentLocation = paymentLocation
        self.paymentTime = paymentTime
        self.paymentID = paymentID
        self.isDeleted = isDeleted
    }
}
