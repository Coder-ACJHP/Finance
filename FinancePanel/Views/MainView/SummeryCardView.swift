//
//  SummeryCardView.swift
//  FinancePanel
//
//  Created by Coder ACJHP on 24.02.2026.
//

import SwiftUI

struct SummeryCardView: View {
    @EnvironmentObject var store: FinanceStore
    
    var body: some View {
        VStack {
            Spacer()
            Text("Total Spent").font(.subheadline).foregroundColor(.secondary)
            Text("$\(store.totalAmount, specifier: "%.2f")")
                .font(.system(size: 40, weight: .bold, design: .rounded))
            Spacer()
        }
        .animation(.smooth(duration: 0.5), value: store.totalAmount)
        .frame(maxWidth: .infinity)
        .background(Color.blue.opacity(0.1))
        .cornerRadius(20)
        .padding(.top, 15)
    }
}
