//
//  AddAccountViewController.swift
//  Keeney
//
//  Created by Xie Liwei on 16/04/2018.
//  Copyright © 2018 Xie Liwei. All rights reserved.
//

import UIKit
import CloudKit

class AddAccountViewController: UIViewController {
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    @IBOutlet weak var accountNameTextfield: UITextField!
    @IBOutlet weak var accountNumberTextfield: UITextField!
    @IBOutlet weak var balanceTextField: UITextField!
    @IBOutlet weak var currencyTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    func updateUI() {
        
    }
    
    @IBAction func saveUserBank(_ sender: Any) {
        if accountNameTextfield.text == "" || accountNumberTextfield.text == "" || balanceTextField.text == "" || currencyTextField.text == "" {
            return
        }
        guard let balance = Double(balanceTextField.text!) else {
            return
        }
        let accountName = accountNameTextfield.text!
        let accountNumber = accountNumberTextfield.text!.replacingOccurrences(of: " ", with: "")
        let currency = currencyTextField.text!
        var account = ["accountName": accountName, "accountNumber": accountNumber, "amount": balance, "currency": currency] as [String : Any]
        AccountService.shared.createNewAccount(account: account) { success, record  in
            if success {
                account["accountRecordName"] = record!.recordID.recordName
                UserDefaultsService.shared.addUserAccount(account: account)
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                    self.navigationController?.popViewController(animated: true)
                })
            } else {
                
            }
        }
    }
    
}
