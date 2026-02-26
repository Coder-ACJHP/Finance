//
//  ChartView.swift
//  FinancePanel
//
//  Created by Coder ACJHP on 24.02.2026.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    @EnvironmentObject var store: FinanceStore
    
    var body: some View {
        VStack {
            Text("Harcama Dağılımı")
                .font(.headline)
                .padding(.vertical, 10)
            
            if store.filteredExpenses.isEmpty {
                // VERİ YOKKEN GÖSTERİLECEK ALAN
                VStack(spacing: 12) {
                    Image(systemName: "chart.pie.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.gray.opacity(0.4))
                    
                    Text("Bu kategoride harcama bulunamadı.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 200) // Grafik ile aynı boyutta olsun ki layout zıplamasın
                .cornerRadius(15)
                
            } else {
                Chart(store.filteredExpenses) { expense in
                    BarMark(
                        x: .value("Kategori", expense.category.rawValue),
                        y: .value("Miktar", expense.amount)
                    )
                    .foregroundStyle(by: .value("Kategori", expense.category.rawValue))
                }
                .animation(.smooth(duration: 0.5), value: store.filteredExpenses.count)
                .chartLegend(.hidden)
                .frame(height: 200)
            }
        }
        .background(Color(uiColor: .secondarySystemBackground))
        .cornerRadius(15)
    }
}
