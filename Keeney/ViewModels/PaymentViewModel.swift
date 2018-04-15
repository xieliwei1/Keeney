//
//  PaymentViewModel.swift
//  Keeney
//
//  Created by Xie Liwei on 15/04/2018.
//  Copyright © 2018 Xie Liwei. All rights reserved.
//

import UIKit
import CloudKit
class PaymentViewModel: NSObject {

    var payments = [Payment]()
    
    func getPayments(completion: @escaping ()-> Void) {
        payments.removeAll()
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Bills", predicate: predicate)
        CKContainer.default().privateCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                guard let records = records else {
                    completion()
                    return
                }
                self.handleCloudKitRecordsToPayments(records: records)
                completion()
            }
        }
    }
    
    func handleCloudKitRecordsToPayments(records:[CKRecord]) {
        for record in records {
            let amount = record.object(forKey: "Amount") as? String ?? ""
            let description = record.object(forKey: "Description") as? String ?? ""
            let fromAccount = record.object(forKey: "FromAccount") as? String ?? ""
            let paymentType = record.object(forKey: "PaymentType") as? String ?? ""
            let paymentTime = record.object(forKey: "PaymentTime") as? String ?? ""
            let paymentLocation = record.object(forKey: "PaymentLocation") as? CLLocation
            let payment = Payment(amount: amount, description: description, fromAccount: fromAccount, paymentType: paymentType, paymentLocation: paymentLocation, paymentTime: paymentTime)
            payments.append(payment)
        }
    }
    
    func numbersOfPayment() -> Int {
        return payments.count
    }
    
    func paymentAmount(for indexPath: IndexPath) -> String {
        return payments[indexPath.row].amount
    }
    
    func paymentDescription(for indexPath: IndexPath) -> String {
        return payments[indexPath.row].description
    }
    
    func paymentFromAccount(for indexPath: IndexPath) -> String {
        return payments[indexPath.row].fromAccount
    }
    
}
