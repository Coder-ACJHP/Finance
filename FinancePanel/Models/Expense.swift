//
//  Expense.swift
//  FinancePanel
//
//  Created by Coder ACJHP on 24.02.2026.
//

import Foundation
import SwiftUI

enum Category: String, CaseIterable, Codable {
    case food = "Food", transport = "Transport", rent = "Rent", entertainment = "Entertainment"
    
    var color: Color {
        switch self {
        case .food: return .orange
        case .transport: return .blue
        case .rent: return .purple
        case .entertainment: return .pink
        }
    }
}

struct Expense: Identifiable, Codable {
    var id = UUID()
    let title: String
    let amount: Double
    let category: Category
    let date: Date
}
