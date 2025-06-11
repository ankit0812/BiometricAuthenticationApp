//
//  AuthRepositoryProtocol.swift
//  BiometricAuthenticationApp
//
//  Created by KingpiN on 11/06/25.
//


protocol AuthRepositoryProtocol {
    func saveToken(_ token: String, withBiometricProtection: Bool) -> Bool
    func retrieveTokenWithBiometric(reason: String, completion: @escaping (Result<String, Error>) -> Void)
    func deleteToken()
    func isBiometricAvailable() -> Bool
    func authenticate(reason: String, completion: @escaping (Bool) -> Void)
}
