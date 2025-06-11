//
//  ViewController.swift
//  BiometricAuthenticationApp
//
//  Created by KingpiN on 11/06/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func btnClicked(_ sender: UIButton) {
        let controller = LoginViewController()
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

