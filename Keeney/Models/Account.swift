//
//  Account.swift
//  Keeney
//
//  Created by Xie Liwei on 16/04/2018.
//  Copyright © 2018 Xie Liwei. All rights reserved.
//

import Foundation
import CloudKit

class Account {
    var amount: Double
    var accountName: String
    var accountNumber: String
    var currency: String
    var accountID: CKRecordID
    var isDeleted: String
    
    init(amount: Double, accountName: String, accountNumber: String, currency: String, accountID: CKRecordID, isDeleted: String) {
        self.amount = amount
        self.accountName = accountName
        self.accountNumber = accountNumber
        self.currency = currency
        self.accountID = accountID
        self.isDeleted = isDeleted
    }
}
