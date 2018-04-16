//
//  UserDefaultService.swift
//  Keeney
//
//  Created by Xie Liwei on 16/04/2018.
//  Copyright © 2018 Xie Liwei. All rights reserved.
//

import Foundation
import CloudKit

protocol UserDefaultsServiceProtocol {
    func saveUserAccounts(accounts: [CKRecord])
    func saveUserPayments(payments: [CKRecord])
}

class UserDefaultsService: UserDefaultsServiceProtocol {
    static let shared = UserDefaultsService()
    
    func saveUserAccounts(accounts:[CKRecord]) {
        var accountsArray = [[String: Any]]()
        for account in accounts {
            let accountName = account.object(forKey: "accountName") as? String ?? ""
            let amount = account.object(forKey: "amount") as? Double ?? 0
            let accountNumber = account.object(forKey: "accountNumber") as? String ?? ""
            let currency = account.object(forKey: "currency") as? String ?? ""
            let accountRecordName = account.recordID.recordName
            let isDeleted = account.object(forKey: "isDeleted") as? String ?? "false"
            let accountDic = ["accountName" : accountName,
                              "amount": amount,
                              "accountNumber": accountNumber,
                              "currency": currency,
                              "accountRecordName": accountRecordName,
                              "isDeleted": isDeleted] as [String : Any]
            accountsArray.append(accountDic)
        }
        UserDefaults.standard.set(accountsArray, forKey: "UserAccounts")
    }
    
    func getUserAccounts()-> [Account]? {
        guard let accountsArray = UserDefaults.standard.object(forKey: "UserAccounts") as? [[String: Any]] else {
            return nil
        }
        var accounts = [Account]()
        for account in accountsArray {
            guard let accountName = account["accountName"] as? String,
            let amount = account["amount"] as? Double,
            let accountNumber = account["accountNumber"] as? String,
            let currency = account["currency"] as? String,
            let accountRecordName = account["accountRecordName"] as? String,
            let isDeleted = account["isDeleted"] as? String else { return nil}
            let accountID = CKRecordID(recordName: accountRecordName)
            let accountObject = Account(amount: amount, accountName: accountName, accountNumber: accountNumber, currency: currency, accountID: accountID, isDeleted: isDeleted)
            accounts.append(accountObject)
        }
        return accounts
    }
    
    func addUserAccount(account: [String: Any]) {
        guard var accountsArray = UserDefaults.standard.object(forKey: "UserAccounts") as? [[String: Any]] else {
            let accountsArray = account
            UserDefaults.standard.set(accountsArray, forKey: "UserAccounts")
            return
        }
        accountsArray.append(account)
        UserDefaults.standard.set(accountsArray, forKey: "UserAccounts")
    }
    
    func saveUserPayments(payments: [CKRecord]) {
        var paymentsArray = [[String: Any]]()
        for payment in payments {
            let amount = payment.object(forKey: "Amount") as? String ?? ""
            let description = payment.object(forKey: "Description") as? String ?? ""
            let fromAccount = payment.object(forKey: "FromAccount") as? String ?? ""
            let paymentType = payment.object(forKey: "PaymentType") as? String ?? ""
            let paymentTime = payment.object(forKey: "PaymentTime") as? String ?? ""
            let paymentLocation = payment.object(forKey: "PaymentLocation") as? CLLocation
            let latitude = paymentLocation?.coordinate.latitude ?? 0
            let longitude = paymentLocation?.coordinate.longitude ?? 0
            let paymentIDName = payment.recordID.recordName
            let isDeleted = payment.object(forKey: "isDeleted") as? String ?? "false"
            let paymentDic = ["description" : description,
                              "amount": amount,
                              "fromAccount": fromAccount,
                              "paymentType": paymentType,
                              "paymentTime": paymentTime,
                              "paymentLatitude": latitude,
                              "paymentLongitude": longitude,
                              "paymentIDName": paymentIDName,
                              "isDeleted": isDeleted] as [String : Any]
            paymentsArray.append(paymentDic)
        }

        UserDefaults.standard.set(paymentsArray, forKey: "UserPayments")
    }
    
    func getUserPayments() -> [Payment]? {
        guard let paymentsArray = UserDefaults.standard.object(forKey: "UserPayments") as? [[String: Any]] else {
            return nil
        }
        print(paymentsArray)
        var payments = [Payment]()
        for payment in paymentsArray {
            guard let description = payment["description"] as? String,
                let amount = payment["amount"] as? String,
                let fromAccount = payment["fromAccount"] as? String,
                let paymentType = payment["paymentType"] as? String,
                let paymentTime = payment["paymentTime"] as? String,
                let paymentLatitude = payment["paymentLatitude"] as? Double,
                let paymentLongitude = payment["paymentLongitude"] as? Double,
                let paymentIDName = payment["paymentIDName"] as? String,
                let isDeleted = payment["isDeleted"] as? String else { return nil}
            let paymentID = CKRecordID(recordName: paymentIDName)
            let paymentLocation = CLLocation(latitude: paymentLatitude, longitude: paymentLongitude)
            if isDeleted != "true" {
                let paymentObject = Payment(amount: amount, description: description, fromAccount: fromAccount, paymentType: paymentType, paymentLocation: paymentLocation, paymentTime: paymentTime, paymentID: paymentID, isDeleted: isDeleted)
                payments.append(paymentObject)
            }
        }
        return payments
    }
    
    func addNewPayment(payment: [String: Any]) {
        guard var paymentsArray = UserDefaults.standard.object(forKey: "UserPayments") as? [[String: Any]] else {
            let paymentsArray = payment
            UserDefaults.standard.set(paymentsArray, forKey: "UserAccounts")
            return
        }
        paymentsArray.append(payment)
        UserDefaults.standard.set(paymentsArray, forKey: "UserAccounts")
    }
}
