//
//  AddExpenseView.swift
//  FinancePanel
//
//  Created by Coder ACJHP on 24.02.2026.
//

import SwiftUI

struct AddExpenseView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var store: FinanceStore
    @FocusState private var isInputActive: Bool
    
    // MARK: - Local State (Form Verileri)
    @State private var title: String = ""
    @State private var amount: String = "" // TextField için String tutup sonra Double'a çevireceğiz
    @State private var selectedCategory: Category = .food
    @State private var date: Date = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Genel Bilgiler") {
                    TextField("Harcama Başlığı", text: $title)
                        .focused($isInputActive)
                    TextField("Miktar", text: $amount)
                        .keyboardType(.decimalPad) // Sadece rakam ve virgül
                        .focused($isInputActive)
                }
                
                Section("Kategori ve Tarih") {
                    Picker("Kategori", selection: $selectedCategory) {
                        ForEach(Category.allCases, id: \.self) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    .pickerStyle(.automatic)
                    
                    DatePicker("Tarih", selection: $date, displayedComponents: .date)
                }
                
                Section {
                    Button(action: saveExpense) {
                        Text("Kaydet")
                            .frame(maxWidth: .infinity)
                            .fontWeight(.bold)
                    }
                    .accessibilityIdentifier("button_save_expense")
                    .disabled(title.isEmpty || amount.isEmpty) // Boşsa buton pasif
                }
            }
            .navigationTitle("Yeni Harcama")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("İptal") { dismiss() }
                }
                // Klavyenin üstündeki grup
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer() // Butonu en sağa iter
                    Button("Done") { isInputActive = false }
                        .fontWeight(.bold) // Daha belirgin olsun
                }
            }
        }
    }
    
    // MARK: - Helper Functions
    private func saveExpense() {
        // String miktarı Double'a güvenli bir şekilde çeviriyoruz
        if let actualAmount = Double(amount.replacingOccurrences(of: ",", with: ".")) {
            let newExpense = Expense(
                title: title,
                amount: actualAmount,
                category: selectedCategory,
                date: date
            )
            
            // Sayfayı kapatıyoruz
            dismiss()
            
            Task {
                // Yaklaşık 0.4 saniye bekle (Nanisaniye cinsinden)
                try? await Task.sleep(for: .seconds(0.4))
                
                // Veriyi ana thread'de (MainActor) animasyonla ekle
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    store.addExpense(newExpense)
                }
            }
        }
    }
}
