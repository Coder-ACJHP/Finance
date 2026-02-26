//
//  FinanceStore.swift
//  FinancePanel
//
//  Created by Coder ACJHP on 24.02.2026.
//

import Foundation
import Combine

class FinanceStore: ObservableObject {
    
    @Published var expenses: [Expense] = [] {
        didSet {
            saveData()
        }
    }
    @Published var selectedCategory: Category? = nil
    
    private let saveKey = "saved_expenses"
    
    var filteredExpenses: [Expense] {
        guard let selectedCategory else { return expenses }
        return expenses.filter { $0.category == selectedCategory }
    }
    
    var totalAmount: Double {
        filteredExpenses.reduce(0) { $0 + $1.amount }
    }
    
    func addExpense(_ expense: Expense) {
        expenses.append(expense)
    }
    
    init() {
        loadData()
    }
    
    private func saveData() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(expenses) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    private func loadData() {
        if let savedData = UserDefaults.standard.data(forKey: saveKey) {
            let decoder = JSONDecoder()
            if let loadedExpenses = try? decoder.decode([Expense].self, from: savedData) {
                expenses = loadedExpenses
            }
        }
    }
}
