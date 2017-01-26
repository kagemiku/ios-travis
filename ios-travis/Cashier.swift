//
//  Cashier.swift
//  ios-travis
//
//  Created by KAGE on 1/23/17.
//  Copyright © 2017 KAGE. All rights reserved.
//

import Foundation

enum CashierError: Error {
    case insufficientFundsError(shortage: Int)
}

final class Cashier {
    private var balance: Int = 0

    init(balance: Int) {
        self.balance = balance
    }

    func getBalance() -> Int {
        return self.balance
    }

    @discardableResult
    func deposit(amount: Int) -> Int {
        self.balance += amount

        return self.balance
    }

    @discardableResult
    func withdraw(amount: Int) throws -> Int {
        if amount > self.balance {
            throw CashierError.insufficientFundsError(shortage: amount - self.balance)
        }

        self.balance -= amount

        return self.balance
    }
}
