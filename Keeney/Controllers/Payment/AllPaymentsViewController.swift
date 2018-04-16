//
//  AllPaymentsViewController.swift
//  Keeney
//
//  Created by Xie Liwei on 15/04/2018.
//  Copyright © 2018 Xie Liwei. All rights reserved.
//

import UIKit

class AllPaymentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var paymentTableView: UITableView!
    @IBOutlet var viewModel: PaymentViewModel!
    @IBOutlet weak var noPaymentImageView: UIImageView!
    @IBOutlet weak var noPaymentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        paymentTableView.delegate = self
        paymentTableView.dataSource = self
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        viewModel.getPayments {
            DispatchQueue.main.async {
                self.paymentTableView.reloadData()
            }
        }
    }
    
    func updateUI() {
        navigationController?.navigationBar.tintColor = UIColor.keeneyGreen
        navigationController?.navigationBar.barTintColor = UIColor.keeneyBackgroundWhite
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = NSLocalizedString("#PaymentsTitle", comment: "")
        noPaymentLabel.text = NSLocalizedString("#NoPayment", comment: "")
    }
    
    //MARK:- tableview delegate and data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.numbersOfPayment() == 0 {
            tableView.separatorStyle = .none
            self.noPaymentView()
            return 0
        }
        noPaymentImageView.alpha = 0
        noPaymentLabel.alpha = 0
        return viewModel.numbersOfPayment()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "paymentsCell", for: indexPath) as! PaymentTableViewCell
        cell.paymentAmoutLabel.text = viewModel.paymentAmount(for: indexPath)
        cell.paymentDescriptionLabel.text = viewModel.paymentDescription(for: indexPath)
        cell.paymentFromAccountLabel.text = viewModel.paymentFromAccount(for: indexPath)
        return cell 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let actionView = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let actionDelete = UIAlertAction(title: "Delete", style: .destructive) { UIAlertAction in
            let alert = UIAlertController(title: "Do you want to delete this payment?", message: nil, preferredStyle: .alert)
            let ok = UIKit.UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.viewModel.delectPayment(for: indexPath, completion: { success in
                    if success {
                        DispatchQueue.main.async {
                            self.paymentTableView.reloadData()
                        }
                    }
                })
            })
            let cancel = UIKit.UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(ok)
            alert.addAction(cancel)
            alert.view.tintColor = UIColor.keeneyGreen
            self.present(alert, animated: true, completion: nil)
            alert.view.tintColor = UIColor.keeneyGreen
        }
        
        let actionEdit = UIAlertAction(title: "Edit", style: .default) { UIAlertAction in
            
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionView.addAction(actionEdit)
        actionView.addAction(actionDelete)
        actionView.addAction(actionCancel)
        DispatchQueue.main.async {
            self.present(actionView, animated: true, completion: nil)
        }
    }
    
    //MARK:- No payment
    func noPaymentView () {
        noPaymentImageView.alpha = 1
        noPaymentLabel.alpha = 1
        self.paymentTableView.backgroundColor = UIColor.keeneyEmptyDataBackgroundGrey
    }
}
