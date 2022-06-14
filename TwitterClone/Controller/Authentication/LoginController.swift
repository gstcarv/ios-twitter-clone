//
//  LoginController.swift
//  TwitterClone
//
//  Created by Gustavo Carvalho on 08/06/22.
//

import Foundation
import UIKit

class LoginController: UIViewController {
    
    // MARK: - Properties
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(named: "TwitterLogo")
        return iv;
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = Utilities().inputContainerView(
            withImage: UIImage(named: "ic_mail_outline_white_2x-1")!,
            textField: emailTextField
        )
        
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = Utilities().inputContainerView(
            withImage: UIImage(named: "ic_lock_outline_white_2x")!,
            textField: passwordTextField
        )
        
        return view
    }()
    
    private let emailTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Email")
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor(named: "TwitterBlue"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button;
    }()
    
    private let dontHaveAnAccountButton: UIButton = {
        let button = Utilities().attributedButton("Don't have an account?", " Sign Up")
        button.addTarget(self, action: #selector(handleGotoSignUpScreen), for: .touchUpInside)
        return button;
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Selectors
    @objc func handleLogin() {
        print("hello worls")
    }
    
    @objc func handleGotoSignUpScreen() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }

    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = UIColor(named: "AccentColor")
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(logoImageView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 120),
            logoImageView.heightAnchor.constraint(equalToConstant: 120),
        ])
        
        let authFormStack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView])
        authFormStack.axis = .vertical
        authFormStack.spacing = 12
        
        view.addSubview(authFormStack)
        
        authFormStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            authFormStack.topAnchor.constraint(equalTo: logoImageView.bottomAnchor),
            authFormStack.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 24),
            authFormStack.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -24),
        ])
        
        view.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginButton.rightAnchor.constraint(equalTo: authFormStack.rightAnchor),
            loginButton.leftAnchor.constraint(equalTo: authFormStack.leftAnchor),
            loginButton.topAnchor.constraint(equalTo: authFormStack.bottomAnchor, constant: 24),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(dontHaveAnAccountButton)
        
        dontHaveAnAccountButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dontHaveAnAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dontHaveAnAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12)
        ])
    }
    
}
