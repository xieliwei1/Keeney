//
//  PaymentService.swift
//  Keeney
//
//  Created by Xie Liwei on 16/04/2018.
//  Copyright © 2018 Xie Liwei. All rights reserved.
//

import Foundation
import CloudKit

protocol PaymentServiceProtocol {
    func getPaymentsFromCloud(completion: @escaping ()-> Void)
    func loadPayments() -> [Payment]?
}

class PaymentService: PaymentServiceProtocol {
    static let shared = PaymentService()
    
    func getPaymentsFromCloud(completion: @escaping ()-> Void) {
        let predicate = NSPredicate(format: "isDeleted != %@", "true")
        let sort = NSSortDescriptor(key: "PaymentTime", ascending: true)
        let query = CKQuery(recordType: "Bills", predicate: predicate)
        query.sortDescriptors = [sort]
        database.perform(query, inZoneWith: nil) { (payments, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                guard let payments = payments else { return }
                UserDefaultsService.shared.saveUserPayments(payments: payments)
                completion()
            }
        }
    }
    func addPayment() {
        
    }
    func loadPayments() -> [Payment]? {
        return UserDefaultsService.shared.getUserPayments()
    }
    
    
}
