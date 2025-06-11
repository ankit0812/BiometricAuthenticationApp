//
//  AuthRepository.swift
//  BiometricAuthenticationApp
//
//  Created by KingpiN on 11/06/25.
//


class AuthRepository: AuthRepositoryProtocol {
    
    private let keychain = KeychainService()
    private let biometric = BiometricService()

    func saveToken(_ token: String, withBiometricProtection: Bool) -> Bool {
        return keychain.saveToken(token, requiresBiometric: withBiometricProtection)
    }

    func retrieveTokenWithBiometric(reason: String, completion: @escaping (Result<String, Error>) -> Void) {
        keychain.retrieveTokenWithBiometrics(reason: reason, completion: completion)
    }

    func deleteToken() {
        keychain.deleteToken()
    }

    func isBiometricAvailable() -> Bool {
        return biometric.isBiometricAvailable()
    }

    func authenticate(reason: String, completion: @escaping (Bool) -> Void) {
        biometric.authenticate(reason: reason, completion: completion)
    }
}

