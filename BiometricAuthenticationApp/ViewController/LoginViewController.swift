//
//  LoginViewController.swift
//  BiometricAuthenticationApp
//
//  Created by KingpiN on 11/06/25.
//

import UIKit

class LoginViewController: UIViewController {
    private let viewModel = LoginViewModel(
        authUseCase: AuthenticateWithBiometricsUseCase(
            repository: AuthRepository()
        )
    )

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login with Biometrics", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(loginButton)

        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)

        viewModel.onTokenRetrieved = { token in
            let alert = UIAlertController(title: "Success", message: "Token: \(token)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }

        viewModel.onError = { error in
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }

    @objc private func handleLogin() {
        viewModel.attemptBiometricLogin()
    }
}
