//
//  MainDashboard.swift
//  FinancePanel
//
//  Created by Coder ACJHP on 24.02.2026.
//

import SwiftUI

private enum WhichSheet: String, CaseIterable, Identifiable {
    case addExpense
    case logout
    
    var id: String { self.rawValue }
}

struct MainDashboard: View {
    @EnvironmentObject var store: FinanceStore
    @EnvironmentObject var authManager: AuthManager
    @State private var whichSheet: WhichSheet?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    // BudgetView
                    SummeryCardView()
                    
                    // Category Picker
                    FilterView()
                    
                    // ChartView
                    ChartView()
                    
                    // List
                    ExpenseListView()
                }
                .padding(16)
            }
            .navigationTitle(Text("My Budget"))
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button {
                        whichSheet = .logout
                    } label: {
                        Image(systemName: "gearshape.fill").font(.title2)
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        whichSheet = .addExpense
                    } label: {
                        Image(systemName: "plus.circle.fill").font(.title2)
                    }
                }
            }
            .sheet(item: $whichSheet) { type in
                switch type {
                    case .addExpense:
                        AddExpenseView()
                    case .logout:
                        SettingsView()
                }
            }
            .onChange(of: store.selectedCategory) { _ in
                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {}
            }
        }
    }
}

#Preview {
    MainDashboard()
        .environmentObject(FinanceStore())
        .environmentObject(AuthManager())
}
