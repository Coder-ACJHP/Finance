//
//  FinancePanelUITests.swift
//  FinancePanelUITests
//
//  Created by Coder ACJHP on 24.02.2026.
//

import XCTest

final class FinancePanelUITests: XCTestCase {
    
    let app = XCUIApplication()

    @MainActor
    override func setUpWithError() throws {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // Relaunch before test
        app.launch()
    }
    
    func test_should_add_new_expense_successfully() {
        let addButton = app.navigationBars["My Budget"].buttons["Add"]
        XCTAssertTrue(addButton.waitForExistence(timeout: 5))
        addButton.tap()
        
        let textField = app.textFields["Harcama Başlığı"]
        XCTAssertTrue(textField.exists)
        textField.tap()
        textField.typeText(String("Test Sinema"))
        
        let addExpenseButton = app.textFields["Miktar"]
        XCTAssertTrue(addExpenseButton.exists)
        addExpenseButton.tap()
        addExpenseButton.typeText("99,99")
        
        app.toolbars.buttons["Done"].tap()
        
        let saveButton = app.buttons["button_save_expense"]
        saveButton.tap()
        
        let newExpenseLabel = app.staticTexts["Test Sinema"]
        XCTAssertTrue(newExpenseLabel.waitForExistence(timeout: 2), "Yeni harcama listede görünmüyor!")
    }
}
