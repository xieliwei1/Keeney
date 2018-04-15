//
//  PaymentTableViewCell.swift
//  Keeney
//
//  Created by Xie Liwei on 15/04/2018.
//  Copyright © 2018 Xie Liwei. All rights reserved.
//

import UIKit

class PaymentTableViewCell: UITableViewCell {
    @IBOutlet weak var paymentAmoutLabel: UILabel!
    @IBOutlet weak var paymentDescriptionLabel: UILabel!
    
    @IBOutlet weak var paymentFromAccountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
