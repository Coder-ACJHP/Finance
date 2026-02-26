//
//  AuthView.swift
//  FinancePanel
//
//  Created by Coder ACJHP on 25.02.2026.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 30) {
            // Logo veya İkon
            Image(systemName: "lock.shield.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
                .padding(.top, 50)
            
            Text("Finance Panel")
                .font(.largeTitle)
                .bold()

            VStack(spacing: 15) {
                TextField("E-posta", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                
                SecureField("Şifre", text: $password)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(.horizontal)

            Button(action: {
                authManager.login()
            }) {
                Text("Giriş Yap")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            Spacer()
        }
    }
}

#Preview {
    AuthView()
}
