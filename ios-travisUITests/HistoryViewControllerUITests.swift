//
//  HistoryViewControllerUITests.swift
//  ios-travis
//
//  Created by KAGE on 1/27/17.
//  Copyright © 2017 KAGE. All rights reserved.
//

import XCTest
@testable import ios_travis

class HistoryViewControllerUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBack() {
        let app = XCUIApplication()
        let historyButton = app.navigationBars["Main"].buttons["History"]
        historyButton.tap()

        let backButton = app.navigationBars["History"].buttons["Main"]
        backButton.tap()

        let navigationBar = app.navigationBars["Main"]
        XCTAssertTrue(navigationBar.exists)
    }

    func testHistoryTableView() {
        let app = XCUIApplication()
        let textField = app.textFields["amountTextField"]
        let depositButton = app.buttons["depositButton"]
        let withdrawButton = app.buttons["withdrawButton"]

        let histories: [History] = [
            History.deposit(100),
            History.deposit(200),
            History.withdraw(300)
        ]

        textField.tap()
        for history in histories {
            switch history {
            case .deposit(let amount):
                textField.typeText(String(amount))
                depositButton.tap()
            case .withdraw(let amount):
                textField.typeText(String(amount))
                withdrawButton.tap()
            }
        }

        let historyButton = app.navigationBars["Main"].buttons["History"]
        historyButton.tap()

        let historyTableView = app.tables
        let cells = historyTableView.cells
        XCTAssertEqual(cells.count, UInt(histories.count))

        for i in 0 ..< histories.count {
            let cellData: (String, String) = {
                switch histories.reversed()[i] {
                case .deposit(let amount):
                    return ("Deposit", String(amount))
                case .withdraw(let amount):
                    return ("Withdraw", String(amount))
                }
            }()

            let cell = cells.element(boundBy: UInt(i))
            let typeLabel   = cell.staticTexts[cellData.0]
            let amountLabel = cell.staticTexts[cellData.1]
            XCTAssertTrue(typeLabel.exists)
            XCTAssertTrue(amountLabel.exists)
        }
    }
}
