//
//  RegistrationController.swift
//  TwitterClone
//
//  Created by Gustavo Carvalho on 08/06/22.
//

import Foundation
import UIKit

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    private let alreadyHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Already have an account?", " Sign In")
        button.addTarget(self, action: #selector(handleGotoLogin), for: .touchUpInside)
        return button;
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    @objc func handleGotoLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = UIColor(named: "AccentColor")
        view.addSubview(alreadyHaveAccountButton)
        
        alreadyHaveAccountButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            alreadyHaveAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alreadyHaveAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12)
        ])
    }
    
}
