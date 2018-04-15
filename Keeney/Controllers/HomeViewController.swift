//
//  HomeViewController.swift
//  Keeney
//
//  Created by Xie Liwei on 15/04/2018.
//  Copyright © 2018 Xie Liwei. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var addPaymentButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }

    func updateUI() {
        addPaymentButton.layer.cornerRadius = 8
        navigationController?.navigationBar.tintColor = UIColor.keeneyGreen
        navigationController?.navigationBar.barTintColor = UIColor.keeneyBackgroundWhite
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @IBAction func addAPayment(_ sender: Any) {
        
    }
    


}
