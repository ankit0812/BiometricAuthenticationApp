//
//  AuthenticateWithBiometricsUseCase.swift
//  BiometricAuthenticationApp
//
//  Created by KingpiN on 11/06/25.
//

import Foundation

class AuthenticateWithBiometricsUseCase {
    private let repository: AuthRepositoryProtocol

    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }

    func execute(reason: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard repository.isBiometricAvailable() else {
            completion(.failure(NSError(domain: "Biometric", code: -1, userInfo: [NSLocalizedDescriptionKey: "Biometric authentication not available"])))
            return
        }

        repository.authenticate(reason: reason) { [weak self] success in
            if success {
                // Save token after successful authentication
                let dummyToken = "secure_dummy_token_123"
                let saved = self?.repository.saveToken(dummyToken, withBiometricProtection: true) ?? false
                if saved {
                    completion(.success(dummyToken))
                } else {
                    completion(.failure(NSError(domain: "Keychain", code: -3, userInfo: [NSLocalizedDescriptionKey: "Failed to save token"])))
                }
            } else {
                completion(.failure(NSError(domain: "Biometric", code: -2, userInfo: [NSLocalizedDescriptionKey: "Authentication failed"])))
            }
        }
    }
}
