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

    var payments = PaymentService.shared.loadPayments()
    
    func getPayments(completion: @escaping ()-> Void) {
        PaymentService.shared.getPaymentsFromCloud {
            self.payments = PaymentService.shared.loadPayments()
            completion()
        }
    }

    
    func numbersOfPayment() -> Int {
        guard let payments = payments else {
            return 0
        }
        return payments.count
    }
    
    func paymentAmount(for indexPath: IndexPath) -> String {
        guard let payments = payments else {
            return ""
        }
        return payments[indexPath.row].amount
    }
    
    func paymentDescription(for indexPath: IndexPath) -> String {
        guard let payments = payments else {
            return ""
        }
        return payments[indexPath.row].description
    }
    
    func paymentFromAccount(for indexPath: IndexPath) -> String {
        guard let payments = payments else {
            return ""
        }
        return payments[indexPath.row].fromAccount
    }
    
    func delectPayment(for indexPath: IndexPath, completion: @escaping (_ success: Bool)-> Void) {
        guard let paymentID = payments?[indexPath.row].paymentID else { return }
        database.fetch(withRecordID: paymentID) { (record, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            } else {
                record?.setObject("true" as CKRecordValue, forKey: "isDeleted")
                database.save(record!, completionHandler: { (record, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        completion(false)
                    } else {
                        self.getPayments {
                            completion(true)
                        }
                    }
                })
            }
        }
    }
}
