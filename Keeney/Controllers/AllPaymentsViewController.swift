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
    var noPaymentImageView: UIImageView?
    var noPaymentLabel: UILabel?
    
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
                print(self.viewModel.payments)
                self.paymentTableView.reloadData()
            }
        }
    }
    
    func updateUI() {
        navigationController?.navigationBar.tintColor = UIColor.keeneyGreen
        navigationController?.navigationBar.barTintColor = UIColor.keeneyBackgroundWhite
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = NSLocalizedString("#PaymentsTitle", comment: "")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.numbersOfPayment() == 0 {
            tableView.separatorStyle = .none
            noChatView()
            return 0
        }
        noPaymentImageView?.removeFromSuperview()
        noPaymentLabel?.removeFromSuperview()
        return viewModel.numbersOfPayment()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "paymentsCell", for: indexPath) as! PaymentTableViewCell
        cell.paymentAmoutLabel.text = viewModel.paymentAmount(for: indexPath)
        cell.paymentDescriptionLabel.text = viewModel.paymentDescription(for: indexPath)
        cell.paymentFromAccountLabel.text = viewModel.paymentFromAccount(for: indexPath)
        return cell 
    }
    
    func noChatView () {
        if noPaymentImageView == nil && noPaymentLabel == nil {
            noPaymentImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 128, height: 116))
            noPaymentLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 264, height: 80))
            noPaymentImageView!.image = UIImage(named: "noPayment")
            noPaymentImageView!.center = CGPoint(x: appWidth/2, y: appHeight/2 - 64)
            let noChat = NSLocalizedString("#NoPayment", comment: "")
            noPaymentLabel!.text = noChat
            noPaymentLabel!.textColor = UIColor.keeneyErrorTextGrey
            noPaymentLabel!.center = CGPoint(x: appWidth/2, y: appHeight/2+64)
            noPaymentLabel!.font = UIFont.keeneyRegularFont(size: 17)
            noPaymentLabel?.numberOfLines = 0
            noPaymentLabel?.textAlignment = .center
            noPaymentLabel?.setNeedsLayout()
            paymentTableView.addSubview(noPaymentImageView!)
            paymentTableView.addSubview(noPaymentLabel!)
            paymentTableView.backgroundColor = UIColor.keeneyEmptyDataBackgroundGrey
        }
    }
}
