//
//  FinancePanelTests.swift
//  FinancePanelTests
//
//  Created by Coder ACJHP on 24.02.2026.
//

import XCTest
@testable import FinancePanel

final class FinancePanelTests: XCTestCase {
    
    var sut: FinanceStore!
    
    override func setUp() {
        super.setUp()
        sut = FinanceStore()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_whenExpenseIsAdded_totalAmountShouldBeCorrect() {
        // Given (Ön Hazırlık)
        let expense1 = Expense(title: "Test 1", amount: 100, category: .food, date: Date())
        let expense2 = Expense(title: "Test 2", amount: 50, category: .transport, date: Date())
        
        // When (Eylem)
        sut.addExpense(expense1)
        sut.addExpense(expense2)
        
        // Then (Doğrulama)
        XCTAssertEqual(sut.totalAmount, 150, "Toplam tutar 150 olmalıydı!")
    }
    
    func test_whenCategorySelected_filteredExpensesShouldOnlyContainThatCategory() {
        // Given
        sut.addExpense(Expense(title: "Yemek", amount: 10, category: .food, date: Date()))
        sut.addExpense(Expense(title: "Yemek 2", amount: 20, category: .food, date: Date()))
        sut.addExpense(Expense(title: "Sinema", amount: 50, category: .entertainment, date: Date()))
        
        // When
        sut.selectedCategory = .food
        
        // Then
        XCTAssertEqual(sut.filteredExpenses.count, 2, "Food kategorisinde 2 eleman olmalı!")
        XCTAssertTrue(sut.filteredExpenses.allSatisfy { $0.category == .food })
    }
    
    @MainActor
    func test_whenExpenseAddedWithDelay_itShouldAppearInStore() async {
        // Given
        let newExpense = Expense(title: "Async Test", amount: 100, category: .food, date: Date())
        
        // When
        // Senaryo: Bir Task içinde bekleyip sonra ekliyoruz (AddExpenseView'daki gibi)
        await Task {
            try? await Task.sleep(for: .seconds(0.1))
            sut.addExpense(newExpense)
        }.value
        
        // Then
        XCTAssertEqual(sut.expenses.count, 1)
    }
    
}
