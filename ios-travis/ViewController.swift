//
//  ViewController.swift
//  ios-travis
//
//  Created by KAGE on 1/22/17.
//  Copyright © 2017 KAGE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!

    private var cashier: Cashier = Cashier(balance: 10000)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.balanceLabel.text = String(self.cashier.getBalance())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapDepositButton(_ sender: Any) {
        guard let text = self.amountTextField.text, let amount = Int(text) else {
            return
        }

        let balance = self.cashier.deposit(amount: amount)
        self.balanceLabel.text = String(balance)
        self.amountTextField.text = ""
    }

    @IBAction func didTapWithdrawButton(_ sender: Any) {
        guard let text = self.amountTextField.text, let amount = Int(text) else {
            return
        }

        var balance = 0
        do {
            balance = try self.cashier.withdraw(amount: amount)
        } catch CashierError.insufficientFundsError(let shortage) {
            log.debug("AlertViewController will be shown")

            let alertVC = UIAlertController(title: "Error", message: "Amount(\(shortage)) is larger than current balance.", preferredStyle: .alert)
            alertVC.view.accessibilityIdentifier = "alert"
            let okButton: UIAlertAction = UIAlertAction(title: "OK", style: .default) { [weak self] action in
                self?.amountTextField.text = ""
            }
            alertVC.addAction(okButton)
            self.present(alertVC, animated: true, completion: nil)
            return
        } catch {
            fatalError("Uncaught exception was threw")
        }

        self.balanceLabel.text = String(balance)
        self.amountTextField.text = ""
    }
}
