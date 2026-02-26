//
//  SettingsView.swift
//  FinancePanel
//
//  Created by Coder ACJHP on 25.02.2026.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss // Sayfayı kapatmak için tetikleyici
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        NavigationStack { // Navigasyon barının görünmesi için şart!
            List {
                Section("Hesap") {
                    Button(action: {
                        // Dismiss the sheet
                        dismiss()
                        // Wait for animation then trigger logout op.
                        Task {
                            try await Task.sleep(for: .seconds(0.5))
                            
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                authManager.logout()
                            }
                        }
                    }) {
                        Label("Çıkış Yap", systemImage: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(.red)
                    }
                }
                
                Section("Uygulama") {
                    HStack {
                        Text("Versiyon")
                        Spacer()
                        Text("1.0.0").foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Ayarlar")
            .navigationBarTitleDisplayMode(.inline) // Başlığı ortada ve küçük yapar
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Bitti") {
                        dismiss() // Sheet'i kapatır
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
