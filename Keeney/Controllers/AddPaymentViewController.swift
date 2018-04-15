//
//  AddPaymentViewController.swift
//  Keeney
//
//  Created by Xie Liwei on 12/04/2018.
//  Copyright © 2018 Xie Liwei. All rights reserved.
//

import UIKit
import CloudKit
class AddPaymentViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var purposeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var purposeTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var bankAccountPicker: UIPickerView!
    @IBOutlet weak var billTypeView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    var fromAccount : String?
    var paymentType : String?
    var locationManager : CLLocationManager?
    override func viewDidLoad() {
        super.viewDidLoad()
        adjustUI()
        bankAccountPicker.dataSource = self
        bankAccountPicker.delegate = self
        paymentType = "Food"
        fromAccount = "Nordea ****4588"
        requestLocationAccess()

    }
    
    func adjustUI() {
        saveButton.layer.cornerRadius = 8
    }
    
    func requestLocationAccess() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied {

        }
    }
    //MARK:- picker delegate and data source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let datasource = ["支付宝 442***","微信 xlw***", "Nordea ****4588"]
        return datasource[row]
    }
    
    @IBAction func saveOnePayment(_ sender: Any) {
        let record = CKRecord(recordType: "Bills")
        guard let description = purposeTextField.text,
            let amount = amountTextField.text,
            let account = fromAccount,
            let type = paymentType else { return }
        let date = Int(Date.timeIntervalBetween1970AndReferenceDate)
        record.setObject(description as CKRecordValue, forKey: "Description")
        record.setObject(amount as CKRecordValue, forKey: "Amount")
        record.setObject(account as CKRecordValue, forKey: "FromAccount")
        record.setObject(type as CKRecordValue, forKey: "PaymentType")
        record.setObject("\(date)" as CKRecordValue, forKey: "PaymentTime")
        if let location = locationManager?.location {
            record.setObject(location as CKRecordValue, forKey: "PaymentLocation")
        }
        CKContainer.default().privateCloudDatabase.save(record) { (ckRecord, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print(ckRecord)
            }
        }
    }
    
    
}

