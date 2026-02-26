//
//  SplashView.swift
//  FinancePanel
//
//  Created by Coder ACJHP on 25.02.2026.
//

import SwiftUI

struct SplashView: View {
    
    @State private var isActive = false
    @State private var opacity = 0.5
    @StateObject private var store = FinanceStore()
    @StateObject private var authManager = AuthManager()
    
    var body: some View {
        if isActive {
            if authManager.isLoggedIn {
                MainDashboard()
                    .environmentObject(store)
                    .environmentObject(authManager)
                    .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
            } else {
                AuthView()
                    .environmentObject(authManager)
                    .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
            }
        } else {
            VStack {
                Image(systemName: "lock.shield.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                    .padding(.top, 50)
                    .opacity(opacity)
            }
            .onAppear {
                withAnimation(.easeIn(duration: 1.2)) {
                    self.opacity = 1.0
                }
                // 2 saniye sonra ana ekrana geç
                Task {
                    try? await Task.sleep(for: .seconds(2.0))
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
