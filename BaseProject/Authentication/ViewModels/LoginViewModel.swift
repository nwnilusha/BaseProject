//
//  LoginViewModel.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 9/6/25.
//

import Foundation

class LoginViewModel: ObservableObject {

    var authManager = BiometricAuthManager()
    @Published var isLoggedIn = false
    @Published var errorMessage: String?
    
    func authenticate() {
        authManager.authenticateWithBiometrics { success, error in
            if success {
                self.isLoggedIn = true
                DebugLogger.shared.log("Face ID authentication success.")
            } else {
                self.errorMessage = error
                DebugLogger.shared.log("Face ID authentication failed.")
            }
        }
    }
    
    func logout() {
        isLoggedIn = false
        KeychainManager.clearLoginStatus()
    }
    
    func autoAuthenticateIfNeeded() {
        if KeychainManager.getLoginStatus() {
            authenticate()
        }
    }
}
