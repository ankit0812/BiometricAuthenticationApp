//
//  KeychainService.swift
//  BiometricAuthenticationApp
//
//  Created by KingpiN on 11/06/25.
//

import Foundation
import LocalAuthentication

class KeychainService {
    
    private let account = "secure_token"

    func saveToken(_ token: String, requiresBiometric: Bool) -> Bool {
        guard let data = token.data(using: .utf8) else { return false }

        var query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: account,
                                    kSecValueData as String: data]

        if requiresBiometric {
            let accessControl = SecAccessControlCreateWithFlags(nil,
                                                                kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
                                                                .userPresence, nil)
            query[kSecAttrAccessControl as String] = accessControl
        }
        SecItemDelete(query as CFDictionary)
        return SecItemAdd(query as CFDictionary, nil) == errSecSuccess
    }

    func retrieveTokenWithBiometrics(reason: String, completion: @escaping (Result<String, Error>) -> Void) {
        let context = LAContext()
        context.localizedReason = reason
        
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: account,
                                    kSecReturnData as String: true,
                                    kSecUseAuthenticationContext as String: context]
        
        var item: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        if status == errSecSuccess, let data = item as? Data, let token = String(data: data, encoding: .utf8) {
            completion(.success(token))
        } else {
            completion(.failure(NSError(domain: "Keychain", code: Int(status), userInfo: nil)))
        }
    }

    func deleteToken() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account
        ]
        SecItemDelete(query as CFDictionary)
    }
}
