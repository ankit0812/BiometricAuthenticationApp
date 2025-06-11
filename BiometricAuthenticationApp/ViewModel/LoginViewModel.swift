//
//  LoginViewModel.swift
//  BiometricAuthenticationApp
//
//  Created by KingpiN on 11/06/25.
//

class LoginViewModel {
    
    private let authUseCase: AuthenticateWithBiometricsUseCase
    var onTokenRetrieved: ((String) -> Void)?
    var onError: ((String) -> Void)?

    init(authUseCase: AuthenticateWithBiometricsUseCase) {
        self.authUseCase = authUseCase
    }

    func attemptBiometricLogin() {
        authUseCase.execute(reason: "Log in with Face ID / Touch ID") { [weak self] result in
            switch result {
            case .success(let token):
                self?.onTokenRetrieved?(token)
            case .failure(let error):
                self?.onError?(error.localizedDescription)
            }
        }
    }
}
