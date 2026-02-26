//
//  AuthManager.swift
//  FinancePanel
//
//  Created by Coder ACJHP on 25.02.2026.
//

import Foundation
import Combine
import SwiftUI

class AuthManager: ObservableObject {
    
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    
    func login() {
        withAnimation(.spring()) {
            isLoggedIn = true
        }
    }
    
    func logout() {
        withAnimation(.spring()) {
            isLoggedIn = false
        }
    }
}
