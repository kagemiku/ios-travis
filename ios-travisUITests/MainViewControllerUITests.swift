//
//  MainViewControllerUITests.swift
//  ios-travisUITests
//
//  Created by KAGE on 1/22/17.
//  Copyright © 2017 KAGE. All rights reserved.
//

import XCTest

class MainViewControllerUITests: XCTestCase {
        
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
    
    func testDeposit() {
        let app = XCUIApplication()
        let textField = app.textFields["amountTextField"]
        textField.tap()
        textField.typeText("100")

        let depositButton = app.buttons["depositButton"]
        depositButton.tap()

        let balanceLabel = app.staticTexts["balanceLabel"]

        XCTAssertEqual(balanceLabel.label, "10100")
    }

    func testWithdraw() {
        let app = XCUIApplication()
        let textField = app.textFields["amountTextField"]
        textField.tap()
        textField.typeText("100")

        let withdrawButton = app.buttons["withdrawButton"]
        withdrawButton.tap()

        let balanceLabel = app.staticTexts["balanceLabel"]

        XCTAssertEqual(balanceLabel.label, "9900")
    }

    func testWithdraw_WithAlert() {
        let app = XCUIApplication()
        let textField = app.textFields["amountTextField"]
        textField.tap()
        textField.typeText("10001")

        let withdrawButton = app.buttons["withdrawButton"]
        withdrawButton.tap()

        let alert = app.alerts["alert"]
        XCTAssertTrue(alert.exists)

        let messageLabel = alert.staticTexts["Amount is larger than current balance. Shortage is 1."]
        XCTAssertTrue(messageLabel.exists)

        alert.buttons["OK"].tap()
        XCTAssertFalse(alert.exists)
    }

    func testHistory() {
        let app = XCUIApplication()
        let historyButton = app.navigationBars["Main"].buttons["History"]
        historyButton.tap()

        let navigationBar = app.navigationBars["History"]
        XCTAssertTrue(navigationBar.exists)
    }
}
