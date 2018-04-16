//
//  AccountViewModel.swift
//  Keeney
//
//  Created by Xie Liwei on 16/04/2018.
//  Copyright © 2018 Xie Liwei. All rights reserved.
//

import UIKit
import CloudKit

class AccountViewModel: NSObject {
    var accounts = AccountService.shared.loadAccounts()
    
    func getAccounts(completion: @escaping ()-> Void) {
        AccountService.shared.getAccountsFromCloud {
            self.accounts = AccountService.shared.loadAccounts()
            completion()
        }
    }
    func refreshAccounts(completion: @escaping ()-> Void) {
        accounts = AccountService.shared.loadAccounts()
    }
    func numbersOfAccounts() -> Int {
        guard let accounts = accounts else { return 0}
        return accounts.count
    }
    
    func accountAmount(for indexPath: IndexPath) -> String {
        guard let accounts = accounts else { return ""}
        let amount = accounts[indexPath.row].amount
        let currency = accounts[indexPath.row].currency
        return "\(amount) \(currency)"
    }
    
    func accountName(for indexPath: IndexPath) -> String {
        guard let accounts = accounts else { return ""}
        return accounts[indexPath.row].accountName
    }
    
    func accountNumber(for indexPath: IndexPath) -> String {
        guard let accounts = accounts else { return ""}
        return accounts[indexPath.row].accountNumber
    }
    
    func didSelectAccount(for indexPath: IndexPath){
        guard let accounts = accounts else { return }
        let account = accounts[indexPath.row]
        print(account.accountID.recordName)
    }
}
