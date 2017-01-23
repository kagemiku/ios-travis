//
//  CashierTests.swift
//  ios-travisTests
//
//  Created by KAGE on 1/22/17.
//  Copyright © 2017 KAGE. All rights reserved.
//

import XCTest
@testable import ios_travis

class CashierTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testGetBalance() {
        let balance = 10000
        let cashier = Cashier(balance: balance)
        XCTAssertEqual(cashier.getBalance(), balance)
    }

    func testDeposit() {
        let balance = 10000
        let amount  = 1000
        let cashier = Cashier(balance: balance)

        XCTAssertEqual(cashier.deposit(amount: amount), balance + amount)
        XCTAssertEqual(cashier.getBalance(), balance + amount)
    }

    func testWithdraw() {
        let balance = 10000
        let amount1 = 1000
        let amount2 = 10001
        let cashier = Cashier(balance: balance)

        XCTAssertEqual(try! cashier.withdraw(amount: amount1), balance - amount1)
        XCTAssertEqual(cashier.getBalance(), balance - amount1)

        cashier.deposit(amount: amount1)
        XCTAssertThrowsError(try cashier.withdraw(amount: amount2)) { error in
            if let e = error as? CashierError, case .insufficientFundsError(let shortage) = e {
                XCTAssertEqual(shortage, amount2 - balance)
            } else {
                XCTAssert(false)
            }
        }
    }
}
