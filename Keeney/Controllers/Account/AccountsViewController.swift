//
//  AccountsViewController.swift
//  Keeney
//
//  Created by Xie Liwei on 16/04/2018.
//  Copyright © 2018 Xie Liwei. All rights reserved.
//

import UIKit

class AccountsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var accountsTableView: UITableView!
    @IBOutlet var viewModel: AccountViewModel!
    @IBOutlet weak var noBankImageView: UIImageView!
    @IBOutlet weak var noBankLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountsTableView.delegate = self
        accountsTableView.dataSource = self
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.getAccounts {
            DispatchQueue.main.async {
                self.accountsTableView.reloadData()
            }
        }
    }
    
    func updateUI() {
        navigationController?.navigationBar.tintColor = UIColor.keeneyGreen
        navigationController?.navigationBar.barTintColor = UIColor.keeneyBackgroundWhite
        navigationController?.navigationBar.shadowImage = UIImage()
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: appWidth, height: 1))
        footerView.backgroundColor = UIColor.keeneyGreyLine
        accountsTableView.tableFooterView = footerView
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.numbersOfAccounts() == 0 {
            noBankView()
            return 0
        }
        noBankImageView.alpha = 0
        noBankLabel.alpha = 0
        return viewModel.numbersOfAccounts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "accountsCell", for: indexPath) as! AccountTableViewCell
        
        cell.accountNameLabel.text = viewModel.accountName(for: indexPath)
        cell.accountNumberLabel.text = viewModel.accountNumber(for: indexPath)
        cell.accountAmountLabel.text = viewModel.accountAmount(for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectAccount(for: indexPath)
    }
    
    //MARK:- No bank account
    func noBankView() {
        noBankImageView.alpha = 1
        noBankLabel.alpha = 1
        self.accountsTableView.backgroundColor = UIColor.keeneyEmptyDataBackgroundGrey
    }
}
