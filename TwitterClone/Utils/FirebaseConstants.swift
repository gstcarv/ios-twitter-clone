//
//  FIRConstants.swift
//  TwitterClone
//
//  Created by Gustavo Carvalho on 20/07/22.
//

import FirebaseStorage
import FirebaseFirestore

// References
let FIRESTORE_REF = Firestore.firestore()
let STORAGE_REF = Storage.storage().reference()

// Firestore Collections
let FIRUsers = FIRESTORE_REF.collection("users")

// Storage references
let FIRProfileImagesStorage = STORAGE_REF.child("profile_images")

