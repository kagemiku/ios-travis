//
//  MainViewController.swift
//  ios-travis
//
//  Created by KAGE on 1/22/17.
//  Copyright © 2017 KAGE. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    @IBOutlet private weak var balanceLabel: UILabel!
    @IBOutlet private weak var amountTextField: UITextField!

    private var cashier: Cashier = Cashier(balance: 10000)
    private var histories: [History] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.balanceLabel.text = String(self.cashier.getBalance())
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.amountTextField.resignFirstResponder()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHistorySegue" {
            log.debug("showHistorySegue")
            if let vc = segue.destination as? HistoryViewController {
                vc.configure(histories: self.histories)
            }
        }
    }

    @IBAction private func didTapDepositButton(_ sender: Any) {
        guard let text = self.amountTextField.text, let amount = Int(text) else {
            return
        }

        let balance = self.cashier.deposit(amount: amount)
        self.balanceLabel.text = String(balance)
        self.amountTextField.text = ""

        self.histories.append(History.deposit(amount))
    }

    @IBAction private func didTapWithdrawButton(_ sender: Any) {
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

        self.histories.append(History.withdraw(amount))
    }
}
