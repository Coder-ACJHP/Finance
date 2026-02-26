//
//  FilterView.swift
//  FinancePanel
//
//  Created by Coder ACJHP on 24.02.2026.
//

import SwiftUI

struct FilterView: View {
    @EnvironmentObject var store: FinanceStore
    
    var body: some View {
        HStack {
            Text("Filtrele:")
                .font(.title2)
            Spacer()
            Picker("Filtrele", selection: $store.selectedCategory) {
                Text("All").tag(nil as Category?)
                    .font(.caption)
                ForEach(Category.allCases, id: \.self) { category in
                    Text(category.rawValue).tag(category as Category?)
                }
            }
            .pickerStyle(.menu)
        }
    }
}
