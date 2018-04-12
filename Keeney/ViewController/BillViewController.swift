//
//  BillViewController.swift
//  Keeney
//
//  Created by Xie Liwei on 12/04/2018.
//  Copyright © 2018 Xie Liwei. All rights reserved.
//

import UIKit

class BillViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var purposeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var purposeTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var bankAccountPicker: UIPickerView!
    @IBOutlet weak var billTypeView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adjustUI()
        bankAccountPicker.dataSource = self
        bankAccountPicker.delegate = self
    }
    
    func adjustUI() {
        saveButton.layer.cornerRadius = 8
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
}

