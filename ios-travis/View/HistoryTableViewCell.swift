//
//  HistoryTableViewCell.swift
//  ios-travis
//
//  Created by KAGE on 1/27/17.
//  Copyright © 2017 KAGE. All rights reserved.
//

import UIKit

final class HistoryTableViewCell: UITableViewCell {
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!

    func configure(_ history: History) {
        switch history {
        case .deposit(let amount):
            self.typeLabel.text   = "Deposit"
            self.amountLabel.text = String(amount)
        case .withdraw(let amount):
            self.typeLabel.text   = "Withdraw"
            self.amountLabel.text = String(amount)
        }
    }
}
