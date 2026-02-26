//
//  ExpenseListView.swift
//  FinancePanel
//
//  Created by Coder ACJHP on 24.02.2026.
//

import SwiftUI

struct ExpenseListView: View {
    @EnvironmentObject var store: FinanceStore
    
    var body: some View {
        VStack(alignment: .leading) {
            if store.filteredExpenses.isEmpty {
                Text("Henüz harcama yok")
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 24)
            } else {
                LazyVStack(spacing: 0) {
                    ForEach(store.filteredExpenses) { expense in
                        HStack {
                            Text(expense.title)
                                .foregroundStyle(Color.mint)
                                .fontWeight(.medium)
                            Text("$\(expense.amount, specifier: "%.2f")")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .init(horizontal: .trailing, vertical: .center))
                                .padding(.trailing, 15)
                            Spacer()
                            Text(expense.date.formatted(.dateTime))
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 12)
                    }
                    .onDelete { indexSet in
                        withAnimation(.easeInOut) {
                            store.expenses.remove(atOffsets: indexSet)
                        }
                    }
                }
            }
        }
        .padding(10)
        .background(Color(uiColor: .secondarySystemBackground))
        .cornerRadius(15)
    }
}
