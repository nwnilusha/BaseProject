//
//  BiometricAuthManager.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 26/5/25.
//

import LocalAuthentication
import Foundation

class BiometricAuthManager: ObservableObject {
    func authenticateWithBiometrics(completion: @escaping (Bool, String?) -> Void) {
        let context = LAContext()
        var error: NSError?

        let reason = "Authenticate to access your account"

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                DispatchQueue.main.async {
                    if success {
                        KeychainManager.saveLoginStatus(true)
                        completion(true, nil)
                    } else {
                        let message = authError?.localizedDescription ?? "Authentication failed"
                        completion(false, message)
                    }
                }
            }
        } else {
            completion(false, error?.localizedDescription ?? "Biometric authentication not available")
        }
    }
    
    func logout() {
        KeychainManager.saveLoginStatus(false)
    }
}

