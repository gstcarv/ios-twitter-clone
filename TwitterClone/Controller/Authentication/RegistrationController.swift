//
//  RegistrationController.swift
//  TwitterClone
//
//  Created by Gustavo Carvalho on 08/06/22.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    
    let imagePicker = UIImagePickerController()
    
    private var profileImage: UIImage?
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Already have an account?", " Sign In")
        button.addTarget(self, action: #selector(handleGotoLogin), for: .touchUpInside)
        return button;
    }()
    
    private let plusPhotoSelector: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.layer.cornerRadius = 150 / 2
        button.layer.masksToBounds = true
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.clipsToBounds = true
        return button
    }()
    
    private lazy var emailContainerView: UIView = {
        let image = UIImage(named: "ic_mail_outline_white_2x-1")
        let container = Utilities().inputContainerView(withImage: image!, textField: emailTextField)
        return container
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = UIImage(named: "ic_lock_outline_white_2x")
        let container = Utilities().inputContainerView(withImage: image!, textField: passwordTextField)
        return container
    }()
    
    private lazy var fullnameContainerView: UIView = {
        let image = UIImage(named: "ic_person_outline_white_2x")
        let container = Utilities().inputContainerView(withImage: image!, textField: fullnameTextField)
        return container
    }()
    
    private lazy var usernameContainerView: UIView = {
        let image = UIImage(named: "ic_person_outline_white_2x")
        let container = Utilities().inputContainerView(withImage: image!, textField: usernameTextField)
        return container
    }()
    
    private let emailTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Email")
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Password")
        return tf
    }()
    
    private let fullnameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Fullname")
        return tf
    }()
    
    private let usernameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Username")
        return tf
    }()
    
    private let registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(UIColor(named: "TwitterBlue"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
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
    
    @objc func handleSelectPhoto() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func handleRegistration() {
        guard let profileImage = profileImage else {
            return ErrorHandler.handleError(self, err: nil, message: "Select the profile image")
        }
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let username = usernameTextField.text else { return }
        guard let fullname = fullnameTextField.text else { return }
        
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else { return }
        
        let profileImageStorageRef = FIRProfileImagesStorage.child(UUID().uuidString);
        
        // Uploads the user profile image
        profileImageStorageRef.putData(imageData, metadata: nil) { (meta, error) in
            
            // Try to get the profile image url
            profileImageStorageRef.downloadURL { url, error in
                
                if let error = error {
                    return ErrorHandler.handleError(self, err: error, message: error.localizedDescription)
                }
                
                guard let profileImageUrl = url?.absoluteString else { return }
                
                // Register user on Firebase Authentication
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if let error = error {
                        return ErrorHandler.handleError(self, err: error, message: error.localizedDescription)
                    }
                    
                    guard let uid = result?.user.uid else { return }
                    
                    let userInformation = [
                        "email": email,
                        "password": password,
                        "username": username,
                        "fullname": fullname,
                        "profileImageUrl": profileImageUrl
                    ]
                    
                    // Save user information on the database
                    FIRUsers.document(uid).setData(userInformation) { error in
                        if let error = error {
                            return ErrorHandler.handleError(self, err: error, message: error.localizedDescription)
                        }
                         
                        let successAlert = UIAlertController.init(title: "Account created", message: "Your account was created successfully", preferredStyle: .alert)
                        
                        successAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: .none))
                        
                        self.present(successAlert, animated: true) {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
        }
    
    }
    
    // MARK: - Helpers
    func configureUI() {
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        view.backgroundColor = UIColor(named: "AccentColor")
        view.addSubview(alreadyHaveAccountButton)
        
        alreadyHaveAccountButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            alreadyHaveAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alreadyHaveAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12)
        ])
        
        view.addSubview(plusPhotoSelector)
        plusPhotoSelector.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            plusPhotoSelector.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            plusPhotoSelector.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plusPhotoSelector.heightAnchor.constraint(equalToConstant: 150),
            plusPhotoSelector.widthAnchor.constraint(equalToConstant: 150),
        ])
        
        let registerFormStack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, fullnameContainerView, usernameContainerView])
        registerFormStack.axis = .vertical
        registerFormStack.spacing = 12
        
        view.addSubview(registerFormStack)
        
        registerFormStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            registerFormStack.topAnchor.constraint(equalTo: plusPhotoSelector.bottomAnchor, constant: 24),
            registerFormStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            registerFormStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
        ])
        
        view.addSubview(registrationButton)
        
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            registrationButton.topAnchor.constraint(equalTo: registerFormStack.bottomAnchor, constant: 24),
            registrationButton.leftAnchor.constraint(equalTo: registerFormStack.leftAnchor),
            registrationButton.rightAnchor.constraint(equalTo: registerFormStack.rightAnchor),
            registrationButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}

// MARK: - UIImagePickerControllerDelegate

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        
        self.profileImage = profileImage;
        
        plusPhotoSelector.layer.borderColor = UIColor.white.cgColor
        plusPhotoSelector.layer.borderWidth = 2
        
        self.plusPhotoSelector.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        dismiss(animated: true, completion: nil)
    }
}
