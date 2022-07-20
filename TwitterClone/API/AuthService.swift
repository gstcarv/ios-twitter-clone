//
//  AuthService.swift
//  TwitterClone
//
//  Created by Gustavo Carvalho on 20/07/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    
    static let shared = AuthService()
    
    func registerUser(credentials: AuthCredentials, completion: @escaping(Error?) -> Void) {
        let email = credentials.email
        let password = credentials.password
        let fullname = credentials.fullname
        let username = credentials.username
        let profileImage = credentials.profileImage
        
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else { return }
        
        let profileImageStorageRef = FIRProfileImagesStorage.child(UUID().uuidString);
        
        // Uploads the user profile image
        profileImageStorageRef.putData(imageData, metadata: nil) { (meta, error) in
            
            // Try to get the profile image url
            profileImageStorageRef.downloadURL { url, error in
                
                if let error = error {
                    return completion(error)
                }
                
                guard let profileImageUrl = url?.absoluteString else { return }
                
                // Register user on Firebase Authentication
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if let error = error {
                        return completion(error)
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
                            return completion(error)
                        }
                                            
                        return completion(nil)
                    }
                }
            }
        }

    }
    
}
