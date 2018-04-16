//
//  AccountService.swift
//  Keeney
//
//  Created by Xie Liwei on 16/04/2018.
//  Copyright © 2018 Xie Liwei. All rights reserved.
//

import Foundation
import CloudKit

protocol AccountServiceProtocol {
    func getAccountsFromCloud(completion: @escaping ()-> Void)
    func loadAccounts() -> [Account]?
}

class AccountService: AccountServiceProtocol {
    static let shared = AccountService()

    func getAccountsFromCloud(completion: @escaping ()-> Void) {
        let predicate = NSPredicate(format: "isDeleted != %@", "true")
        
        let query = CKQuery(recordType: "Accounts", predicate: predicate)
        database.perform(query, inZoneWith: nil) { (accounts, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                guard let accounts = accounts else {
                    return
                }
                UserDefaultsService.shared.saveUserAccounts(accounts: accounts)
                completion()
            }
        }
    }
    
    func loadAccounts() -> [Account]? {
        return UserDefaultsService.shared.getUserAccounts()
    }
    
    func createNewAccount(account: [String: Any], completion: @escaping (Bool, CKRecord?)-> Void) {
        let record = CKRecord(recordType: "Accounts")
        let accountName = account["accountName"] as! String
        let accountNumber = account["accountNumber"] as! String
        let currency = account["currency"] as! String
        let amount = account["amount"] as! Double
        record.setObject(accountName as CKRecordValue, forKey: "accountName")
        record.setObject(accountNumber as CKRecordValue, forKey: "accountNumber")
        record.setObject(currency as CKRecordValue, forKey: "currency")
        record.setObject(amount as CKRecordValue, forKey: "amount")
        record.setObject("false" as CKRecordValue, forKey: "isDeleted")
        
        database.save(record) { (savedRecord, error) in
            if let error = error {
                completion(false, savedRecord)
            } else {
                completion(true, savedRecord)
            }
        }
    }
    
}
